import 'package:flutter/material.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/theme.dart';
import 'package:my_portfolio/widgets/common.dart';

/// Sticky bar: wordmark, section links and the résumé download. Gains a
/// hairline and solid background once the page has scrolled.
class TopBar extends StatelessWidget {
  const TopBar(
      {super.key,
      required this.scrolled,
      required this.sections,
      required this.onNavigate});

  final bool scrolled;
  final List<String> sections;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    final showLinks = MediaQuery.sizeOf(context).width >= 900;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: scrolled
            ? Palette.paper.withValues(alpha: 0.97)
            : Palette.paper.withValues(alpha: 0),
        border: Border(
            bottom: BorderSide(
                color: scrolled ? Palette.hairline : Colors.transparent)),
      ),
      child: ContentWidth(
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => onNavigate('top'),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(Profile.shortName,
                          overflow: TextOverflow.ellipsis,
                          style: Fonts.title(19)),
                    ),
                  ),
                ),
              ),
              if (showLinks)
                for (final s in sections)
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: _NavLink(label: s, onTap: () => onNavigate(s)),
                  ),
              const SizedBox(width: 28),
              _ResumeLink(compact: size == ScreenSize.mobile),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: Fonts.body(
              size: 14.5,
              color: _hover ? Palette.ink : Palette.inkSoft,
              weight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _ResumeLink extends StatelessWidget {
  const _ResumeLink({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openUrl(Profile.resumePath),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Palette.ink),
          ),
          child: Text(compact ? 'Résumé' : 'Résumé (PDF)',
              style: Fonts.body(
                  size: 14, color: Palette.ink, weight: FontWeight.w500)),
        ),
      ),
    );
  }
}
