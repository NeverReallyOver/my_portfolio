import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  static const _services = [
    _Service(
      Icons.phone_android_outlined,
      'Flutter Mobile',
      'Cross-platform iOS & Android apps built from a single codebase with native performance.',
      ['State management', 'REST API integration', 'App store deployment'],
    ),
    _Service(
      Icons.web_outlined,
      'Flutter Web',
      'Responsive web apps using Flutter Web — same Dart codebase, runs in any browser.',
      ['Responsive layouts', 'Firebase Hosting', 'Performance optimization'],
    ),
    _Service(
      Icons.cloud_queue_outlined,
      'API Integration',
      'Connecting Flutter apps to REST APIs and WebSocket streams for real-time data.',
      ['REST endpoints', 'WebSocket feeds', 'Auth flows'],
    ),
    _Service(
      Icons.code_outlined,
      'Java Backend',
      'Full-stack Java development with MySQL and RESTful API design.',
      ['Spring-style APIs', 'MySQL schema design', 'Backend architecture'],
    ),
    _Service(
      Icons.reviews_outlined,
      'Code Review',
      'Architecture advice and code review for existing Flutter projects.',
      ['Architecture review', 'Best practices', 'Performance audit'],
    ),
    _Service(
      Icons.support_agent_outlined,
      'Maintenance & Support',
      'Ongoing updates, bug fixes, and feature additions for live apps.',
      ['Bug fixes', 'Feature additions', 'Dependency upgrades'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1100;
    final colCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// 02',
            style: AppTextStyles.accent.copyWith(
              color: AppColors.textMuted,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Services',
            style: AppTextStyles.sectionTitle.copyWith(
              fontSize: isMobile ? 24 : 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'What I can help you build',
            style: AppTextStyles.body.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 40),
          _buildGrid(colCount, isMobile),
        ],
      ),
    );
  }

  Widget _buildGrid(int colCount, bool isMobile) {
    final rows = <Widget>[];
    for (int i = 0; i < _services.length; i += colCount) {
      final rowItems = _services.skip(i).take(colCount).toList();
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int j = 0; j < rowItems.length; j++) ...[
                if (j > 0) const SizedBox(width: 16),
                Expanded(child: _buildCard(rowItems[j])),
              ],
              // Fill empty cells in last row
              for (int k = rowItems.length; k < colCount; k++) ...[
                const SizedBox(width: 16),
                const Expanded(child: SizedBox()),
              ],
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildCard(_Service s) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(s.icon, size: 18, color: AppColors.accent),
          ),
          const SizedBox(height: 14),
          Text(
            s.title,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.description,
            style: AppTextStyles.body.copyWith(fontSize: 13, height: 1.65),
          ),
          const SizedBox(height: 14),
          ...s.points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      p,
                      style: AppTextStyles.body.copyWith(fontSize: 12),
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
}

class _Service {
  final IconData icon;
  final String title;
  final String description;
  final List<String> points;

  const _Service(this.icon, this.title, this.description, this.points);
}
