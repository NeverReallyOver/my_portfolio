import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final Function(GlobalKey) onNavigate;
  final Map<String, GlobalKey> sectionKeys;

  const HeroSection({
    super.key,
    required this.onNavigate,
    required this.sectionKeys,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0E27),
            Color(0xFF0E1340),
            Color(0xFF0A0E27),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Dot-grid texture
          Positioned.fill(
            child: CustomPaint(painter: _DotGridPainter()),
          ),

          // Cyan radial glow — top right
          Positioned(
            top: -180,
            right: -180,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Purple radial glow — bottom left
          Positioned(
            bottom: -120,
            left: -120,
            child: Container(
              width: 480,
              height: 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentPurple.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Gradient fade at bottom for smooth section transition
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.bg.withValues(alpha: 0),
                    AppColors.bg,
                  ],
                ),
              ),
            ),
          ),

          // Content — offset by fixed navbar height
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: kNavBarHeight,
                left: isMobile ? 24 : 80,
                right: isMobile ? 24 : 80,
              ),
              child: isMobile
                  ? _buildMobileContent(context)
                  : _buildDesktopContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: _buildHeroText(false)),
        const SizedBox(width: 80),
        Expanded(flex: 4, child: _buildCodeCard()),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroText(true),
            const SizedBox(height: 48),
            _buildCodeCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroText(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Available badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accentGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accentGreen.withValues(alpha: 0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGreen.withValues(alpha: 0.12),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentGreen.withValues(alpha: 0.6),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Open to new opportunities',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.accentGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Name — diagonal gradient white → cyan
        ShaderMask(
          shaderCallback: (Rect bounds) => const LinearGradient(
            colors: [Color(0xFFE6F0FF), Color(0xFF00D9FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            'Janakiraman\nVelayutham',
            style: AppTextStyles.heroTitle.copyWith(
              fontSize: isMobile ? 40 : 58,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Title
        Text(
          'Flutter Developer',
          style: GoogleFonts.inter(
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.w500,
            color: AppColors.accent,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 6),

        // Dual positioning
        Text(
          'Freelance · Open to Full-time Roles',
          style: GoogleFonts.jetBrainsMono(
            fontSize: isMobile ? 12 : 13,
            color: AppColors.textSecondary,
          ),
        ),

        const SizedBox(height: 24),

        // Description
        SizedBox(
          width: isMobile ? double.infinity : 430,
          child: Text(
            'Building production-grade cross-platform apps with Flutter and Dart. '
            'Currently at Zebu leading MYNT — a real-time trading platform '
            'live on iOS, Android, and Web.',
            style: AppTextStyles.body.copyWith(
              fontSize: 15,
              height: 1.8,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Stat row
        _buildStatRow(),
        const SizedBox(height: 32),

        // CTAs
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildPrimaryButton('View My Work', () {
              final key = sectionKeys['Projects'];
              if (key != null) onNavigate(key);
            }),
            _buildSecondaryButton('Resume ↗', () async {
              final Uri uri = Uri.parse(PortfolioData.resumeUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            }),
          ],
        ),

        const SizedBox(height: 36),

        // Social links
        Row(
          children: [
            _buildSocialLink('GitHub', PortfolioData.githubUrl),
            _buildTextDivider(),
            _buildSocialLink('LinkedIn', PortfolioData.linkedinUrl),
            _buildTextDivider(),
            _buildSocialLink('Email', 'mailto:${PortfolioData.email}'),
          ],
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.bg,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: AppTextStyles.button.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLink(String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTextDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '·',
        style: AppTextStyles.body.copyWith(color: AppColors.border),
      ),
    );
  }

  // Code-editor card showing current work
  Widget _buildCodeCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Window chrome
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                _buildWindowDot(const Color(0xFFFF5F57)),
                const SizedBox(width: 6),
                _buildWindowDot(const Color(0xFFFFBD2E)),
                const SizedBox(width: 6),
                _buildWindowDot(const Color(0xFF28C840)),
                const SizedBox(width: 14),
                Text(
                  'mynt_app.dart',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Code
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _codeLine('// @ Zebu Share & Wealth Managements', AppColors.textMuted),
                const SizedBox(height: 14),
                _codeLine('class MyntTradingApp extends StatefulWidget {', AppColors.textPrimary),
                const SizedBox(height: 4),
                _codeLine('  // Platforms', AppColors.textMuted),
                _codeLine("  static const targets = ['iOS', 'Android', 'Web'];", AppColors.accentOrange),
                const SizedBox(height: 4),
                _codeLine('  // Key features built', AppColors.textMuted),
                _codeLine("  final payoffGraph = RealTimeChart();", AppColors.accentGreen),
                _codeLine("  final portfolio  = MultiStockTracker();", AppColors.accentGreen),
                _codeLine("  final feed       = WebSocketStream();", AppColors.accentGreen),
                const SizedBox(height: 4),
                _codeLine('}', AppColors.textPrimary),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentGreen.withValues(alpha: 0.5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Status: Live in Production',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindowDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _codeLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 13,
          color: color,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildStatRow() {
    return Row(
      children: [
        _buildStat('2+', 'yrs exp'),
        const SizedBox(width: 20),
        Container(width: 1, height: 18, color: AppColors.border),
        const SizedBox(width: 20),
        _buildStat('3', 'platforms'),
        const SizedBox(width: 20),
        Container(width: 1, height: 18, color: AppColors.border),
        const SizedBox(width: 20),
        _buildStat('Live', 'in production'),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value,
          style: AppTextStyles.subHeader.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: AppTextStyles.body.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x1500D9FF) // cyan-tinted dots
      ..style = PaintingStyle.fill;

    const spacing = 28.0;
    const radius = 1.0;

    for (double x = 0; x <= size.width; x += spacing) {
      for (double y = 0; y <= size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
