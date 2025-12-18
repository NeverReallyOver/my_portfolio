import 'package:flutter/material.dart';
import 'dart:async';

/// A widget that animates its child when it comes into view during scrolling
class ScrollAnimationWrapper extends StatefulWidget {
  final Widget child;
  final double delay;
  final AnimationType animationType;
  final Curve curve;
  final Duration duration;

  const ScrollAnimationWrapper({
    super.key,
    required this.child,
    this.delay = 0.0,
    this.animationType = AnimationType.fadeInUp,
    this.curve = Curves.easeOutCubic,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  State<ScrollAnimationWrapper> createState() => _ScrollAnimationWrapperState();
}

class _ScrollAnimationWrapperState extends State<ScrollAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;
  Timer? _checkTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    // Check visibility after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
      _startPeriodicCheck();
    });
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startPeriodicCheck() {
    _checkTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_hasAnimated) {
        timer.cancel();
        return;
      }
      if (mounted) {
        _checkVisibility();
      }
    });
  }

  void _checkVisibility() {
    if (_hasAnimated || !mounted) return;

    final RenderObject? renderObject = context.findRenderObject();
    if (renderObject == null || !renderObject.attached) return;

    try {
      final RenderBox renderBox = renderObject as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      
      if (size.height == 0) return; // Widget not laid out yet
      
      final screenHeight = MediaQuery.of(context).size.height;

      // Check if the widget is in the viewport (with some threshold)
      // Trigger animation when widget is visible in viewport
      final isVisible = position.dy < screenHeight * 0.9 && 
                       position.dy + size.height > -50;

      if (isVisible && !_hasAnimated) {
        _checkTimer?.cancel();
        Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
          if (mounted && !_hasAnimated) {
            setState(() {
              _hasAnimated = true;
            });
            _controller.forward();
          }
        });
      }
    } catch (e) {
      // Handle any errors silently
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only check visibility on scroll end to avoid performance issues
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (!_hasAnimated && mounted) {
          // Small delay to ensure layout is stable
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted && !_hasAnimated) {
              _checkVisibility();
            }
          });
        }
        return false;
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return _buildAnimatedChild();
        },
      ),
    );
  }

  Widget _buildAnimatedChild() {
    switch (widget.animationType) {
      case AnimationType.fadeInUp:
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0, 80 * (1 - _animation.value)),
            child: Transform.scale(
              scale: 0.95 + (0.05 * _animation.value),
              child: widget.child,
            ),
          ),
        );

      case AnimationType.fadeInDown:
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0, -50 * (1 - _animation.value)),
            child: widget.child,
          ),
        );

      case AnimationType.fadeInLeft:
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(-50 * (1 - _animation.value), 0),
            child: widget.child,
          ),
        );

      case AnimationType.fadeInRight:
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(50 * (1 - _animation.value), 0),
            child: widget.child,
          ),
        );

      case AnimationType.fadeIn:
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );

      case AnimationType.scale:
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: 0.85 + (0.15 * _animation.value),
            child: Transform.translate(
              offset: Offset(0, 30 * (1 - _animation.value)),
              child: widget.child,
            ),
          ),
        );

      case AnimationType.slideUp:
        return Transform.translate(
          offset: Offset(0, 100 * (1 - _animation.value)),
          child: widget.child,
        );

      case AnimationType.rotate:
        return Opacity(
          opacity: _animation.value,
          child: Transform.rotate(
            angle: (1 - _animation.value) * 0.1,
            child: widget.child,
          ),
        );
    }
  }
}

enum AnimationType {
  fadeInUp,
  fadeInDown,
  fadeInLeft,
  fadeInRight,
  fadeIn,
  scale,
  slideUp,
  rotate,
}

