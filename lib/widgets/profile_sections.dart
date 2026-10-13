import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/theme.dart';
import 'package:my_portfolio/widgets/common.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    return ContentWidth(
      vertical: size == ScreenSize.mobile ? 56 : 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
              index: '02',
              label: 'Experience',
              title: 'From IT support to shipping a trading app.'),
          const SizedBox(height: 40),
          for (final e in timeline) _TimelineRow(entry: e),
          const Hairline(),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.entry});

  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final wide = screenSizeOf(context) != ScreenSize.mobile;
    final when = Text(entry.when,
        style: Fonts.label(size: 12.5, color: Palette.inkSoft));
    final what = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entry.title,
            style: Fonts.body(
                size: 17, color: Palette.ink, weight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(entry.place, style: Fonts.body(size: 15, color: Palette.muted)),
        if (entry.note.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(entry.note, style: Fonts.body(size: 15)),
        ],
      ],
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Palette.hairline))),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 220,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 4), child: when)),
                Expanded(child: what),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [when, const SizedBox(height: 8), what]),
    );
  }
}

class SkillsAboutSection extends StatelessWidget {
  const SkillsAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    final columns = switch (size) {
      ScreenSize.mobile => 1,
      ScreenSize.tablet => 2,
      ScreenSize.desktop => 4,
    };

    return Container(
      color: Palette.paperSunk,
      child: ContentWidth(
        vertical: size == ScreenSize.mobile ? 56 : 88,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
                index: '03',
                label: 'About',
                title: 'The parts of mobile work that are easy to get wrong.'),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final p in About.paragraphs)
                    Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(p, style: Fonts.body(size: 17))),
                ],
              ),
            ),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, c) {
                const spacing = 32.0;
                final width = (c.maxWidth - spacing * (columns - 1)) / columns;
                return Wrap(
                  spacing: spacing,
                  runSpacing: 32,
                  children: [
                    for (final g in skillGroups)
                      SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Palette.ink, width: 1.5))),
                              child: Text(g.title.toUpperCase(),
                                  style: Fonts.label(
                                      color: Palette.ink,
                                      weight: FontWeight.w600)),
                            ),
                            const SizedBox(height: 12),
                            for (final item in g.items)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 7),
                                child: Text(item, style: Fonts.body(size: 15)),
                              ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    final mobile = size == ScreenSize.mobile;
    return Container(
      color: Palette.ink,
      child: ContentWidth(
        vertical: mobile ? 64 : 104,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('05  CONTACT',
                style: Fonts.label(color: const Color(0xFF9FB3CC))),
            const SizedBox(height: 18),
            Text(
              'Hiring a Flutter developer?\nI\'d like to hear about it.',
              style:
                  Fonts.display(mobile ? 34 : 52).copyWith(color: Colors.white),
            ),
            const SizedBox(height: 32),
            const _CopyEmail(),
            const SizedBox(height: 28),
            Wrap(
              spacing: 28,
              runSpacing: 12,
              children: [
                TextLink(
                    label: 'LinkedIn',
                    url: Profile.linkedinUrl,
                    style: _linkStyle),
                TextLink(
                    label: 'GitHub', url: Profile.githubUrl, style: _linkStyle),
                TextLink(
                    label: 'Résumé (PDF)',
                    url: Profile.resumePath,
                    style: _linkStyle),
                Text(Profile.phone,
                    style: _linkStyle.copyWith(color: const Color(0xFFC9D3DF))),
              ],
            ),
            SizedBox(height: mobile ? 56 : 88),
            Container(height: 1, color: Colors.white.withValues(alpha: 0.14)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 24,
              runSpacing: 8,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text('© ${DateTime.now().year} ${Profile.name}',
                    style: Fonts.label(
                        size: 11.5, color: const Color(0xFF8A97A8))),
                Text('Built with Flutter Web',
                    style: Fonts.label(
                        size: 11.5, color: const Color(0xFF8A97A8))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static TextStyle get _linkStyle =>
      Fonts.body(size: 16, color: Colors.white, weight: FontWeight.w500);
}

/// The email address as a large link, with a copy button so recruiters on
/// machines without a mail client can grab it.
class _CopyEmail extends StatefulWidget {
  const _CopyEmail();

  @override
  State<_CopyEmail> createState() => _CopyEmailState();
}

class _CopyEmailState extends State<_CopyEmail> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: Profile.email));
    setState(() => _copied = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final mobile = screenSizeOf(context) == ScreenSize.mobile;
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TextLink(
          label: Profile.email,
          url: 'mailto:${Profile.email}',
          arrow: false,
          style: Fonts.title(mobile ? 22 : 30).copyWith(color: Colors.white),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _copy,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
              ),
              child: Text(_copied ? 'Copied' : 'Copy',
                  style: Fonts.label(size: 12, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}

class FreelanceSection extends StatelessWidget {
  const FreelanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    final columns = size == ScreenSize.desktop ? 3 : 1;
    return ContentWidth(
      vertical: size == ScreenSize.mobile ? 56 : 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '04',
            label: 'Freelance',
            title: Freelance.title,
            intro: Freelance.intro,
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, c) {
              const spacing = 32.0;
              final width = (c.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: 32,
                children: [
                  for (final o in Freelance.offers)
                    SizedBox(width: width, child: _OfferBlock(offer: o)),
                ],
              );
            },
          ),
          const SizedBox(height: 36),
          PrimaryButton(
            label: 'Tell me about your project',
            icon: Icons.arrow_forward,
            onTap: () => openUrl(
                'mailto:${Profile.email}?subject=${Uri.encodeComponent('Freelance project')}'),
          ),
        ],
      ),
    );
  }
}

class _OfferBlock extends StatelessWidget {
  const _OfferBlock({required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Palette.ink, width: 1.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(offer.title, style: Fonts.title(22)),
          const SizedBox(height: 12),
          Text(offer.body, style: Fonts.body(size: 15.5)),
          const SizedBox(height: 14),
          Text(offer.proof,
              style: Fonts.label(size: 11.5, color: Palette.accent)),
        ],
      ),
    );
  }
}
