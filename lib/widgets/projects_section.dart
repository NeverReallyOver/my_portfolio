import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isMobile),
          const SizedBox(height: 40),
          ...PortfolioData.projects.asMap().entries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildProjectCard(e.value, isMobile, featured: e.key == 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// 04',
          style: AppTextStyles.accent.copyWith(
            color: AppColors.textMuted,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Work',
          style: AppTextStyles.sectionTitle.copyWith(
            fontSize: isMobile ? 24 : 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Things I've built",
          style: AppTextStyles.body.copyWith(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildProjectCard(
    Map<String, String> project,
    bool isMobile, {
    required bool featured,
  }) {
    final hasLink =
        project['link'] != null && project['link']!.isNotEmpty;
    final techTags =
        (project['tech'] ?? '').split(', ').where((t) => t.isNotEmpty).toList();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: featured ? AppColors.accent.withValues(alpha: 0.3) : AppColors.border,
        ),
        boxShadow: featured ? AppShadows.featured : AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: type badge + link icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (featured)
                    _buildBadge('Featured', AppColors.accentOrange),
                  if (featured) const SizedBox(width: 8),
                  _buildBadge(project['type'] ?? 'Project', AppColors.accent),
                ],
              ),
              if (hasLink)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      final uri = Uri.parse(project['link']!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'View live',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 13,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.open_in_new,
                          size: 14,
                          color: AppColors.accent,
                        ),
                      ],
                    ),
                  ),
                )
              else
                _buildNoteChip('Private / NDA'),
            ],
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            project['title'] ?? '',
            style: AppTextStyles.subHeader.copyWith(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          // Description
          Text(
            project['description'] ?? '',
            style: AppTextStyles.body.copyWith(fontSize: 15, height: 1.75),
          ),

          const SizedBox(height: 18),

          // Tech stack
          if (techTags.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: techTags
                  .map((tech) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          tech.trim(),
                          style: AppTextStyles.accent.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyles.accent.copyWith(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNoteChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: AppTextStyles.accent.copyWith(
          fontSize: 11,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
