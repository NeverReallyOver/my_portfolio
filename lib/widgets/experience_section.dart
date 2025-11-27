import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 70,
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
          
          const SizedBox(height: 35),
          
          // Experience timeline
          _buildExperienceTimeline(isMobile),
        ],
      ),
    );
  }

  Widget _buildExperienceTimeline(bool isMobile) {
    // Use real experience data from PortfolioData
    final experiences = PortfolioData.experience.map((exp) {
      // Parse description to extract achievements
      final description = exp['description'] as String;
      final descriptionLines = description.split('\n');
      final mainDesc = descriptionLines.first;
      final achievements = descriptionLines.skip(1)
          .where((line) => line.trim().isNotEmpty)
          .map((line) => line.replaceAll('• ', '').trim())
          .toList();

      return {
        'role': exp['role'],
        'company': exp['company'],
        'duration': exp['period'],
        'location': exp['location'],
        'description': mainDesc,
        'achievements': achievements.isEmpty ? null : achievements,
        'current': exp['current'] == 'true',
      };
    }).toList();

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
    final isCurrent = exp['current'] == true;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile)
            Expanded(
              child: isLeft
                  ? _buildCardContent(exp, isCurrent)
                  : const SizedBox(),
            ),
          
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  gradient: isCurrent
                      ? LinearGradient(
                          colors: [AppColors.accent, AppColors.accentPurple],
                        )
                      : null,
                  color: isCurrent ? null : AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.accent.withOpacity(0.4),
                      AppColors.accent.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: isMobile || !isLeft
                ? _buildCardContent(exp, isCurrent)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(Map<String, dynamic> exp, bool isCurrent) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
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
                isCurrent ? Icons.work : Icons.business_center,
                color: AppColors.accent,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp['role'] as String,
                      style: AppTextStyles.subHeader.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      exp['company'] as String,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 13,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCurrent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.accentPurple],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Current',
                    style: AppTextStyles.accent.copyWith(
                      fontSize: 11,
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
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 5),
              Text(
                exp['duration'] as String,
                style: AppTextStyles.body.copyWith(fontSize: 13),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Description
          Text(
            exp['description'] as String,
            style: AppTextStyles.body.copyWith(fontSize: 13),
          ),
          
          const SizedBox(height: 12),
          
          // Achievements
          if (exp['achievements'] != null) ...[ 
            Text(
              'Key Responsibilities:',
              style: AppTextStyles.subHeader.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 6),
            ...((exp['achievements'] as List).map((achievement) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        achievement,
                        style: AppTextStyles.body.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            }).toList()),
          ],
        ],
      ),
    );
  }
}
