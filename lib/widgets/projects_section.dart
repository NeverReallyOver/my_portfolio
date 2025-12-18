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
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary.withOpacity(0.5),
          ],
        ),
      ),
      child: Column(
        children: [
          // Section header
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Featured Projects',
                    style: AppTextStyles.sectionTitle.copyWith(
                      fontSize: isMobile ? 32 : 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accent,
                            AppColors.accent.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'A showcase of my recent work and projects',
                  style: AppTextStyles.body.copyWith(
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 50),
          
          // Projects grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              childAspectRatio: isMobile ? 1.1 : 1.3,
            ),
            itemCount: PortfolioData.projects.length,
            itemBuilder: (context, index) {
              final project = PortfolioData.projects[index];
              return _buildProjectCard(project, isMobile);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, String> project, bool isMobile) {
    final hasLink = project['link'] != null && project['link']!.isNotEmpty;
    
    return MouseRegion(
      cursor: hasLink ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: hasLink ? () async {
          final uri = Uri.parse(project['link']!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } : null,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.1),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project image placeholder with gradient
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.accent.withOpacity(0.2),
                        AppColors.accentPurple.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          project['type'] == 'Mobile App' 
                              ? Icons.phone_android 
                              : Icons.web,
                          size: 80,
                          color: AppColors.accent.withOpacity(0.5),
                        ),
                      ),
                      if (hasLink)
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.open_in_new,
                              color: AppColors.accent,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              
              // Project content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.accent.withOpacity(0.2),
                              AppColors.accentPurple.withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          project['type'] ?? 'Project',
                          style: AppTextStyles.accent.copyWith(
                            fontSize: 11,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Title
                      Text(
                        project['title'] ?? '',
                        style: AppTextStyles.subHeader.copyWith(
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Description
                      Expanded(
                        child: Text(
                          project['description'] ?? '',
                          style: AppTextStyles.body.copyWith(
                            fontSize: isMobile ? 13 : 14,
                            height: 1.6,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Tech stack
                      if (project['tech'] != null && project['tech']!.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project['tech']!
                              .split(', ')
                              .take(3)
                              .map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.accent.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                tech.trim(),
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

