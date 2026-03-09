import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  final Function(GlobalKey) onNavigate;
  final Map<String, GlobalKey> sectionKeys;

  const NavBar({
    super.key,
    required this.onNavigate,
    required this.sectionKeys,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bg.withValues(alpha: 0.75),
            border: const Border(
              bottom: BorderSide(color: AppColors.border),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: kNavBarHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 80,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo / name
                    Text(
                      'Janakiraman.dev',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 14,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    if (!isMobile)
                      Row(
                        children: [
                          _buildNavLink('About'),
                          _buildNavLink('Services'),
                          _buildNavLink('Skills'),
                          _buildNavLink('Projects'),
                          _buildNavLink('Experience'),
                          _buildNavLink('Contact'),
                          const SizedBox(width: 12),
                          _buildResumeButton(),
                        ],
                      )
                    else
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.textPrimary,
                          size: 22,
                        ),
                        onPressed: () => _showMobileMenu(context),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          final key = sectionKeys[label];
          if (key != null) onNavigate(key);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResumeButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final Uri uri = Uri.parse(PortfolioData.resumeUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Resume ↗',
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              color: AppColors.accent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...['About', 'Services', 'Skills', 'Projects', 'Experience', 'Contact']
                .map(
                  (item) => ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 28),
                    title: Text(
                      item,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      Future.delayed(const Duration(milliseconds: 250), () {
                        final key = sectionKeys[item];
                        if (key != null) onNavigate(key);
                      });
                    },
                  ),
                )
                ,
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
