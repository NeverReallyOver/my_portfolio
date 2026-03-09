import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel(),
          const SizedBox(height: 40),
          isMobile
              ? _buildMobileLayout()
              : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildSectionLabel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// 01',
          style: AppTextStyles.accent.copyWith(
            color: AppColors.textMuted,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text('About', style: AppTextStyles.sectionTitle),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildText()),
        const SizedBox(width: 64),
        Expanded(flex: 2, child: _buildHighlights()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(),
        const SizedBox(height: 40),
        _buildHighlights(),
      ],
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.aboutDescription1,
          style: AppTextStyles.body.copyWith(fontSize: 16, height: 1.8),
        ),
        const SizedBox(height: 20),
        Text(
          PortfolioData.aboutDescription2,
          style: AppTextStyles.body.copyWith(fontSize: 16, height: 1.8),
        ),
        const SizedBox(height: 32),
        _buildQuickFacts(),
      ],
    );
  }

  Widget _buildQuickFacts() {
    return Row(
      children: [
        _buildFact(PortfolioData.yearsExperience, 'years\nprofessional exp'),
        const SizedBox(width: 40),
        _buildFact('3', 'platforms\ndeployed on'),
        const SizedBox(width: 40),
        _buildFact('5+', 'production\nfeatures shipped'),
      ],
    );
  }

  Widget _buildFact(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: AppTextStyles.subHeader.copyWith(
            fontSize: 28,
            color: AppColors.accent,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.body.copyWith(fontSize: 12, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildHighlights() {
    final items = [
      const _HighlightItem(
        Icons.phone_android_outlined,
        'Flutter Mobile',
        'iOS & Android from one codebase',
      ),
      const _HighlightItem(
        Icons.web_outlined,
        'Flutter Web',
        'Same code running in browsers',
      ),
      const _HighlightItem(
        Icons.cloud_queue_outlined,
        'API Integration',
        'REST + WebSocket in production',
      ),
      const _HighlightItem(
        Icons.settings_outlined,
        'State Management',
        'Provider & Riverpod',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildHighlightRow(item),
              ))
          .toList(),
    );
  }

  Widget _buildHighlightRow(_HighlightItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, size: 18, color: AppColors.accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: AppTextStyles.body.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const _HighlightItem(this.icon, this.title, this.subtitle);
}
