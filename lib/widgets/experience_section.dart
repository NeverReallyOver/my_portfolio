import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 40 : 80,
        vertical: isMobile ? 40 : isTablet ? 50 : 70,
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
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 768;
              return isSmallScreen
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Experience',
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: isMobile ? 28 : 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 60,
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accentPurple,
                                AppColors.accentPurple.withOpacity(0),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          'Experience',
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: isTablet ? 36 : 40,
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
                    );
            },
          ),
          
          const SizedBox(height: 12),
          
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'My professional journey and achievements',
              style: AppTextStyles.body.copyWith(
                fontSize: isMobile ? 14 : isTablet ? 16 : 18,
              ),
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
      padding: EdgeInsets.only(bottom: isMobile ? 16 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile)
            Expanded(
              flex: 1,
              child: isLeft
                  ? _buildCardContent(exp, isCurrent, isMobile)
                  : const SizedBox(),
            ),
          
          // Timeline indicator
          Column(
            children: [
              Container(
                width: isMobile ? 14 : 18,
                height: isMobile ? 14 : 18,
                decoration: BoxDecoration(
                  gradient: isCurrent
                      ? const LinearGradient(
                          colors: [AppColors.accent, AppColors.accentPurple],
                        )
                      : null,
                  color: isCurrent ? null : AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: isMobile ? 2 : 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.4),
                      blurRadius: isMobile ? 6 : 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: isMobile ? 60 : 80,
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
          
          SizedBox(width: isMobile ? 12 : 16),
          
          Expanded(
            flex: isMobile ? 1 : 1,
            child: isMobile || !isLeft
                ? _buildCardContent(exp, isCurrent, isMobile)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(Map<String, dynamic> exp, bool isCurrent, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.08),
            blurRadius: isMobile ? 8 : 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isCurrent ? Icons.work : Icons.business_center,
                color: AppColors.accent,
                size: isMobile ? 18 : 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp['role'] as String,
                      style: AppTextStyles.subHeader.copyWith(
                        fontSize: isMobile ? 15 : 17,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      exp['company'] as String,
                      style: AppTextStyles.body.copyWith(
                        fontSize: isMobile ? 12 : 13,
                        color: AppColors.accent,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isCurrent)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 10,
                    vertical: isMobile ? 4 : 5,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.accent, AppColors.accentPurple],
                    ),
                    borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                  ),
                  child: Text(
                    'Current',
                    style: AppTextStyles.accent.copyWith(
                      fontSize: isMobile ? 10 : 11,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: isMobile ? 6 : 8),
          
          // Duration
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: isMobile ? 12 : 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  exp['duration'] as String,
                  style: AppTextStyles.body.copyWith(
                    fontSize: isMobile ? 12 : 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          SizedBox(height: isMobile ? 10 : 12),
          
          // Description
          Text(
            exp['description'] as String,
            style: AppTextStyles.body.copyWith(
              fontSize: isMobile ? 12 : 13,
            ),
          ),
          
          SizedBox(height: isMobile ? 10 : 12),
          
          // Achievements
          if (exp['achievements'] != null) ...[ 
            Text(
              'Key Responsibilities:',
              style: AppTextStyles.subHeader.copyWith(
                fontSize: isMobile ? 13 : 14,
              ),
            ),
            SizedBox(height: isMobile ? 5 : 6),
            ...((exp['achievements'] as List).map((achievement) {
              return Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 4 : 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: isMobile ? 5 : 6),
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: isMobile ? 8 : 10),
                    Expanded(
                      child: Text(
                        achievement,
                        style: AppTextStyles.body.copyWith(
                          fontSize: isMobile ? 11 : 12,
                        ),
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
