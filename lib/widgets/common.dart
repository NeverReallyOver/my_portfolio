import 'package:flutter/material.dart';
import 'package:my_portfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';

const double kMaxContentWidth = 1120;

enum ScreenSize { mobile, tablet, desktop }

ScreenSize screenSizeOf(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 720) return ScreenSize.mobile;
  if (width < 1080) return ScreenSize.tablet;
  return ScreenSize.desktop;
}

Future<void> openUrl(String url) async {
  await launchUrl(Uri.parse(url),
      webOnlyWindowName: url.startsWith('mailto:') ? '_self' : '_blank');
}

/// Centres content at [kMaxContentWidth] with responsive side gutters.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child, this.vertical = 0});

  final Widget child;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    final gutter = screenSizeOf(context) == ScreenSize.mobile ? 20.0 : 40.0;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kMaxContentWidth + 80),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: gutter, vertical: vertical),
          child: child,
        ),
      ),
    );
  }
}

/// Section opener: a numbered mono label, a serif title and an optional intro.
class SectionHeader extends StatelessWidget {
  const SectionHeader(
      {super.key,
      required this.index,
      required this.label,
      required this.title,
      this.intro});

  final String index;
  final String label;
  final String title;
  final String? intro;

  @override
  Widget build(BuildContext context) {
    final mobile = screenSizeOf(context) == ScreenSize.mobile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$index  ${label.toUpperCase()}',
            style: Fonts.label(color: Palette.accent)),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(title, style: Fonts.display(mobile ? 30 : 40)),
        ),
        if (intro != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(intro!, style: Fonts.body(size: mobile ? 16 : 17)),
          ),
        ],
      ],
    );
  }
}

class Hairline extends StatelessWidget {
  const Hairline({super.key});

  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: Palette.hairline);
}

/// Solid ink button for the one primary action on screen.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton(
      {super.key, required this.label, required this.onTap, this.icon});

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _hover ? Palette.accent : Palette.ink,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(widget.label,
                    style: Fonts.body(
                        size: 15,
                        color: Colors.white,
                        weight: FontWeight.w500)),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, size: 16, color: Colors.white),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined button for secondary actions.
class SecondaryButton extends StatefulWidget {
  const SecondaryButton(
      {super.key, required this.label, required this.onTap, this.icon});

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: _hover ? Palette.paperSunk : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Palette.ink.withValues(alpha: 0.85)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(widget.label,
                    style: Fonts.body(
                        size: 15, color: Palette.ink, weight: FontWeight.w500)),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, size: 16, color: Palette.ink),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Inline text link with an underline that appears on hover.
class TextLink extends StatefulWidget {
  const TextLink(
      {super.key,
      required this.label,
      required this.url,
      this.style,
      this.arrow = true});

  final String label;
  final String url;
  final TextStyle? style;
  final bool arrow;

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final base = widget.style ??
        Fonts.body(size: 15, color: Palette.accent, weight: FontWeight.w500);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.url),
        child: Text(
          widget.arrow ? '${widget.label} ↗' : widget.label,
          style: base.copyWith(
            decoration: _hover ? TextDecoration.underline : TextDecoration.none,
            decorationColor: base.color,
          ),
        ),
      ),
    );
  }
}

/// Small rounded tag for stack items.
class Tag extends StatelessWidget {
  const Tag(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: Palette.paperSunk,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: Fonts.label(size: 11.5, color: Palette.inkSoft)),
    );
  }
}

/// Bullet row with an en-dash marker, used for "what I built" lists.
class DashItem extends StatelessWidget {
  const DashItem(this.text, {super.key, this.size = 16});

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child:
                Text('–', style: Fonts.body(size: size, color: Palette.muted)),
          ),
          Expanded(child: Text(text, style: Fonts.body(size: size))),
        ],
      ),
    );
  }
}
