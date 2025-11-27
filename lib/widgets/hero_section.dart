import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_portfolio/constants.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _particleController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _floatingAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
            AppColors.primary,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated background particles
          _buildAnimatedParticles(),
          
          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 60,
                vertical: 20,
              ),
              child: Column(
                children: [
                  // Top navigation bar
                  _buildNavBar(isMobile),
                  
                  Expanded(
                    child: isMobile
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTextContent(isMobile),
                              const SizedBox(height: 40),
                              _buildProfileImage(),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: _buildTextContent(isMobile),
                              ),
                              const SizedBox(width: 60),
                              Expanded(
                                flex: 2,
                                child: _buildProfileImage(),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlesPainter(_particleController.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildNavBar(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo/Name
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accent, AppColors.accentPurple],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.code,
                color: Colors.white,
                size: 24,
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 12),
              Text(
                'Flutter Dev',
                style: AppTextStyles.button.copyWith(fontSize: 18),
              ),
            ],
          ],
        ),
        
        // Nav items
        if (!isMobile)
          Row(
            children: [
              _buildNavItem('About'),
              _buildNavItem('Skills'),
              _buildNavItem('Experience'),
              _buildNavItem('Services'),
              _buildNavItem('Contact'),
            ],
          )
        else
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // TODO: Implement mobile menu
            },
          ),
      ],
    );
  }

  Widget _buildNavItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {},
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for Mobile & Web Projects',
                style: AppTextStyles.accent.copyWith(
                  color: AppColors.accent,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Name with animation
        Text(
          'Your Name Here',
          style: AppTextStyles.heroTitle.copyWith(
            fontSize: isMobile ? 36 : 64,
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Animated job title
        Row(
          children: [
            Text(
              'Flutter Developer',
              style: AppTextStyles.subHeader.copyWith(
                fontSize: isMobile ? 24 : 32,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [AppColors.accent, AppColors.accentPurple],
                  ).createShader(const Rect.fromLTWH(0, 0, 400, 50)),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Description
        SizedBox(
          width: isMobile ? double.infinity : 500,
          child: Text(
            'Passionate Flutter developer crafting beautiful, high-performance mobile and web applications. Specializing in cross-platform development with clean architecture and exceptional user experiences.',
            style: AppTextStyles.body.copyWith(fontSize: isMobile ? 16 : 18),
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Location and experience
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.accent, size: 20),
            const SizedBox(width: 8),
            Text(
              'Your Location',
              style: AppTextStyles.body.copyWith(fontSize: 14),
            ),
            const SizedBox(width: 24),
            Icon(Icons.work, color: AppColors.accent, size: 20),
            const SizedBox(width: 8),
            Text(
              'Freelance Available',
              style: AppTextStyles.body.copyWith(fontSize: 14),
            ),
          ],
        ),
        
        const SizedBox(height: 40),
        
        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildGradientButton(
              'Let\'s Build Together',
              () {},
              icon: Icons.arrow_forward,
            ),
            _buildOutlineButton(
              'View Resume',
              () {},
              icon: Icons.description,
            ),
          ],
        ),
        
        const SizedBox(height: 32),
        
        // Social links
        Row(
          children: [
            _buildSocialIcon(Icons.code),
            _buildSocialIcon(Icons.link),
            _buildSocialIcon(Icons.email),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glowing rings
              ...List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _particleController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (index * 0.15) + (_particleController.value * 0.1),
                      child: Container(
                        width: 300 + (index * 40),
                        height: 300 + (index * 40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.1 - (index * 0.03)),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
              
              // Profile circle with gradient border
              Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent,
                      AppColors.accentPurple,
                      AppColors.accentPink,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    transform: GradientRotation(_particleController.value * 2 * math.pi),
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondary,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/flutter_expertise.png',
                      width: 200,
                      height: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          size: 120,
                          color: AppColors.accent,
                        );
                      },
                    ),
                  ),
                ),
              ),
              
              // Floating tech icons
              ...List.generate(4, (index) {
                return AnimatedBuilder(
                  animation: _particleController,
                  builder: (context, child) {
                    final angle = (index * math.pi / 2) + (_particleController.value * 2 * math.pi);
                    final radius = 180.0;
                    return Transform.translate(
                      offset: Offset(
                        math.cos(angle) * radius,
                        math.sin(angle) * radius,
                      ),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          _getTechIcon(index),
                          color: AppColors.accent,
                          size: 24,
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  IconData _getTechIcon(int index) {
    switch (index) {
      case 0:
        return Icons.phone_android; // Mobile
      case 1:
        return Icons.web; // Web
      case 2:
        return Icons.tablet; // Tablet
      case 3:
        return Icons.flutter_dash; // Flutter
      default:
        return Icons.code;
    }
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed, {IconData? icon}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.accent, AppColors.accentPurple],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text, style: AppTextStyles.button),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, size: 20, color: Colors.white),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(String text, VoidCallback onPressed, {IconData? icon}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.accent, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: AppTextStyles.button.copyWith(color: AppColors.accent),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, size: 20, color: AppColors.accent),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.accent.withOpacity(0.2)),
          ),
          child: Icon(icon, color: AppColors.accent, size: 20),
        ),
      ),
    );
  }
}

class ParticlesPainter extends CustomPainter {
  final double animationValue;
  
  ParticlesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent.withOpacity(0.1)
      ..strokeWidth = 1;

    // Draw particles
    for (int i = 0; i < 50; i++) {
      final x = (i * 100 + animationValue * 200) % size.width;
      final y = (i * 50 + animationValue * 100) % size.height;
      
      canvas.drawCircle(
        Offset(x, y),
        2 + math.sin(animationValue * 2 * math.pi + i) * 1,
        paint,
      );
    }

    // Draw connecting lines
    paint.strokeWidth = 0.5;
    for (int i = 0; i < 20; i++) {
      final x1 = (i * 150 + animationValue * 100) % size.width;
      final y1 = (i * 100) % size.height;
      final x2 = ((i + 1) * 150 + animationValue * 150) % size.width;
      final y2 = ((i + 1) * 100) % size.height;
      
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}
