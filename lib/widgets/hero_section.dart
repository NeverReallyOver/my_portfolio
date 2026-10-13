import 'package:flutter/material.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/theme.dart';
import 'package:my_portfolio/widgets/common.dart';
import 'package:my_portfolio/widgets/live_watchlist.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onSeeWork});

  final VoidCallback onSeeWork;

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    final copy = _Copy(size: size, onSeeWork: onSeeWork);
    final phone = _Phone(width: size == ScreenSize.mobile ? 280 : 300);

    return ContentWidth(
      vertical: size == ScreenSize.mobile ? 40 : 72,
      child: size == ScreenSize.desktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: copy),
                const SizedBox(width: 64),
                phone,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                copy,
                const SizedBox(height: 48),
                Center(child: phone)
              ],
            ),
    );
  }
}

class _Copy extends StatelessWidget {
  const _Copy({required this.size, required this.onSeeWork});

  final ScreenSize size;
  final VoidCallback onSeeWork;

  @override
  Widget build(BuildContext context) {
    final headline = switch (size) {
      ScreenSize.mobile => 40.0,
      ScreenSize.tablet => 56.0,
      ScreenSize.desktop => 64.0,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(HeroCopy.eyebrow.toUpperCase(),
            style: Fonts.label(color: Palette.accent)),
        const SizedBox(height: 20),
        Text(HeroCopy.headline, style: Fonts.display(headline)),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(HeroCopy.intro,
              style: Fonts.body(size: size == ScreenSize.mobile ? 17 : 18.5)),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    color: Palette.available, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Flexible(
                child: Text(Profile.availability,
                    style: Fonts.body(size: 14.5, color: Palette.ink))),
          ],
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            PrimaryButton(
                label: 'See my work',
                icon: Icons.arrow_downward,
                onTap: onSeeWork),
            SecondaryButton(
                label: 'Download résumé',
                onTap: () => openUrl(Profile.resumePath)),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: TextLink(
                  label: Profile.email,
                  url: 'mailto:${Profile.email}',
                  arrow: false),
            ),
          ],
        ),
      ],
    );
  }
}

class _Phone extends StatelessWidget {
  const _Phone({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LiveWatchlist(width: width),
        const SizedBox(height: 16),
        SizedBox(
          width: width,
          child: Text(
            'A live Flutter widget. Prices are simulated; the batching is real.',
            textAlign: TextAlign.center,
            style: Fonts.label(size: 11),
          ),
        ),
      ],
    );
  }
}
