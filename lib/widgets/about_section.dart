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
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 70,
      ),
      child: Column(
        children: [
          // Section header
          Row(
            children: [
              Text(
                'About Me',
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
          
          const SizedBox(height: 35),
          
          // Content
          isMobile
              ? Column(
                  children: [
                    _buildAboutText(isMobile),
                    const SizedBox(height: 40),
                    _buildExpertiseCards(isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildAboutText(isMobile),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 3,
                      child: _buildExpertiseCards(isMobile),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildAboutText(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accentPurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Crafting Digital Excellence',
            style: AppTextStyles.accent.copyWith(
              color: AppColors.accentPurple,
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        Text(
          PortfolioData.aboutTitle,
          style: AppTextStyles.subHeader.copyWith(
            fontSize: isMobile ? 24 : 28,
          ),
        ),
        
        const SizedBox(height: 20),
        
        Text(
          PortfolioData.aboutDescription1,
          style: AppTextStyles.body,
        ),
        
        const SizedBox(height: 16),
        
        Text(
          PortfolioData.aboutDescription2,
          style: AppTextStyles.body,
        ),
        
        const SizedBox(height: 24),
        
        _buildQuickStats(),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildStatItem(PortfolioData.yearsExperience, 'Years Experience'),
        _buildStatItem(PortfolioData.projectsCompleted, 'Projects Completed'),
        _buildStatItem(PortfolioData.clientSatisfaction, 'Client Satisfaction'),
      ],
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: AppTextStyles.subHeader.copyWith(
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [AppColors.accent, AppColors.accentPurple],
              ).createShader(const Rect.fromLTWH(0, 0, 100, 50)),
          ),
        ),
        Text(
          label,
          style: AppTextStyles.body.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildExpertiseCards(bool isMobile) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 1 : 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: isMobile ? 1.3 : 1.7,
      children: [
        _buildExpertiseCard(
          Icons.phone_android,
          'Mobile App Development',
          'Creating native-quality mobile apps for iOS and Android with Flutter\'s cross-platform capabilities.',
          [AppColors.accent, AppColors.accentPurple],
        ),
        _buildExpertiseCard(
          Icons.web,
          'Web Development',
          'Building responsive, performant web applications using Flutter Web with modern UI/UX practices.',
          [AppColors.accentPurple, AppColors.accentPink],
        ),
        _buildExpertiseCard(
          Icons.architecture,
          'Clean Architecture',
          'Implementing scalable architecture patterns with proper state management and dependency injection.',
          [AppColors.accentPink, AppColors.accent],
        ),
        _buildExpertiseCard(
          Icons.speed,
          'Performance Optimization',
          'Optimizing app performance with efficient rendering, caching, and lazy loading techniques.',
          [AppColors.accent, AppColors.accentPurple],
        ),
        _buildExpertiseCard(
          Icons.integration_instructions,
          'API Integration',
          'Seamless integration with REST APIs, GraphQL, Firebase, and various third-party services.',
          [AppColors.accentPurple, AppColors.accentPink],
        ),
        _buildExpertiseCard(
          Icons.brush,
          'UI/UX Implementation',
          'Bringing designs to life with pixel-perfect implementations and smooth animations.',
          [AppColors.accentPink, AppColors.accent],
        ),
      ],
    );
  }

  Widget _buildExpertiseCard(
    IconData icon,
    String title,
    String description,
    List<Color> gradientColors,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: AppDurations.medium,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.accent.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            
            const SizedBox(height: 14),
            
            Text(
              title,
              style: AppTextStyles.subHeader.copyWith(fontSize: 17),
            ),
            
            const SizedBox(height: 10),
            
            Expanded(
              child: Text(
                description,
                style: AppTextStyles.body.copyWith(fontSize: 13),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
