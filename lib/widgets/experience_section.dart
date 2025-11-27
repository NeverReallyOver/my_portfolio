import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withOpacity(0.3),
            AppColors.primary,
          ],
        ),
      ),
      child: Column(
        children: [
          // Section header
          Row(
            children: [
              Text(
                'Experience',
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
                        AppColors.accentPurple,
                        AppColors.accentPurple.withOpacity(0),
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
              'My professional journey and achievements',
              style: AppTextStyles.body,
            ),
          ),
          
          const SizedBox(height: 50),
          
          // Experience timeline
          _buildExperienceTimeline(isMobile),
          
          const SizedBox(height: 40),
          
          // Placeholder for future experiences
          _buildAddMoreCard(isMobile),
        ],
      ),
    );
  }

  Widget _buildExperienceTimeline(bool isMobile) {
    // Sample experience data with placeholders
    final experiences = [
      {
        'role': 'Freelance Flutter Developer',
        'company': 'Self-Employed',
        'duration': 'Present',
        'description':
            'Building custom mobile and web applications for clients worldwide. Specializing in Flutter app development with clean architecture and modern UI/UX.',
        'achievements': [
          'Delivered 10+ successful Flutter projects',
          'Achieved 5-star client ratings consistently',
          'Implemented complex state management solutions',
        ],
        'tech': ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
        'current': true,
      },
      {
        'role': 'Flutter Developer',
        'company': 'Your Previous Company (If Any)',
        'duration': '6 months',
        'description':
            'Developed and maintained mobile applications using Flutter. Collaborated with cross-functional teams to deliver high-quality products.',
        'achievements': [
          'Built responsive UI components',
          'Integrated third-party APIs and services',
          'Improved app performance by 30%',
        ],
        'tech': ['Flutter', 'Dart', 'Firebase'],
        'placeholder': true, // Mark as placeholder for future data
      },
      // Additional placeholder for future experiences
      {
        'role': 'Add Your Experience',
        'company': 'Future Position',
        'duration': 'TBD',
        'description':
            'This is a placeholder for future experience. You can add more details later.',
        'achievements': [
          'Achievement to be added',
          'Achievement to be added',
        ],
        'tech': ['Tech Stack'],
        'placeholder': true,
      },
    ];

    return Column(
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final exp = entry.value;
        return _buildExperienceCard(
          exp,
          isLeft: index % 2 == 0,
          isMobile: isMobile,
        );
      }).toList(),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> exp,
      {required bool isLeft, required bool isMobile}) {
    final isPlaceholder = exp['placeholder'] == true;
    final isCurrent = exp['current'] == true;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile)
            Expanded(
              child: isLeft
                  ? _buildCardContent(exp, isPlaceholder, isCurrent)
                  : const SizedBox(),
            ),
          
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  gradient: isCurrent
                      ? LinearGradient(
                          colors: [AppColors.accent, AppColors.accentPurple],
                        )
                      : null,
                  color: isCurrent ? null : isPlaceholder
                      ? AppColors.accentPurple
                      : AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (isCurrent ? AppColors.accent : AppColors.accentPurple)
                          .withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.accent.withOpacity(0.5),
                      AppColors.accent.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 20),
          
          Expanded(
            child: isMobile || !isLeft
                ? _buildCardContent(exp, isPlaceholder, isCurrent)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(Map<String, dynamic> exp, bool isPlaceholder, bool isCurrent) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isPlaceholder
                ? AppColors.accentPurple.withOpacity(0.3)
                : AppColors.accent.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: (isPlaceholder ? AppColors.accentPurple : AppColors.accent)
                  .withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  isCurrent
                      ? Icons.work
                      : isPlaceholder
                          ? Icons.add_circle_outline
                          : Icons.business_center,
                  color: isPlaceholder ? AppColors.accentPurple : AppColors.accent,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exp['role'] as String,
                        style: AppTextStyles.subHeader.copyWith(
                          fontSize: 20,
                          color: isPlaceholder
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exp['company'] as String,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          color: isPlaceholder
                              ? AppColors.accentPurple
                              : AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.accent, AppColors.accentPurple],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Current',
                      style: AppTextStyles.accent.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Duration
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  exp['duration'] as String,
                  style: AppTextStyles.body.copyWith(fontSize: 14),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Description
            Text(
              exp['description'] as String,
              style: AppTextStyles.body.copyWith(
                fontSize: 15,
                fontStyle: isPlaceholder ? FontStyle.italic : FontStyle.normal,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Achievements
            if (exp['achievements'] != null) ...[
              Text(
                'Key Achievements:',
                style: AppTextStyles.subHeader.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 8),
              ...((exp['achievements'] as List).map((achievement) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isPlaceholder
                              ? AppColors.accentPurple
                              : AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          achievement,
                          style: AppTextStyles.body.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList()),
              const SizedBox(height: 16),
            ],
            
            // Tech stack
            if (exp['tech'] != null)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ((exp['tech'] as List).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: (isPlaceholder
                              ? AppColors.accentPurple
                              : AppColors.accent)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: (isPlaceholder
                                ? AppColors.accentPurple
                                : AppColors.accent)
                            .withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: AppTextStyles.accent.copyWith(
                        fontSize: 12,
                        color: isPlaceholder
                            ? AppColors.accentPurple
                            : AppColors.accent,
                      ),
                    ),
                  );
                }).toList()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMoreCard(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.accentPurple.withOpacity(0.3),
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.add_circle_outline,
            color: AppColors.accentPurple,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'More Experiences Coming Soon',
            style: AppTextStyles.subHeader.copyWith(
              fontSize: 20,
              color: AppColors.accentPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'This section is ready for your future professional experiences and achievements',
            style: AppTextStyles.body.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
