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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.accentPurple.withOpacity(0.2),
                AppColors.accent.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.accentPurple.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code,
                color: AppColors.accentPurple,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'About Me',
                style: AppTextStyles.accent.copyWith(
                  color: AppColors.accentPurple,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 28),
        
        Text(
          'Freelance Flutter Developer',
          style: AppTextStyles.subHeader.copyWith(
            fontSize: isMobile ? 26 : 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 20),
        
        Text(
          PortfolioData.aboutDescription1,
          style: AppTextStyles.body.copyWith(
            fontSize: isMobile ? 15 : 17,
            height: 1.8,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Text(
          PortfolioData.aboutDescription2,
          style: AppTextStyles.body.copyWith(
            fontSize: isMobile ? 15 : 17,
            height: 1.8,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Key Highlights
        _buildHighlights(isMobile),
        
        const SizedBox(height: 32),
        
        _buildQuickStats(),
      ],
    );
  }

  Widget _buildHighlights(bool isMobile) {
    final highlights = [
      {'icon': Icons.phone_android, 'text': 'Mobile Apps'},
      {'icon': Icons.web, 'text': 'Web Apps'},
      {'icon': Icons.design_services, 'text': 'UI/UX Design'},
      {'icon': Icons.support_agent, 'text': 'Freelance Available'},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: highlights.map((highlight) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                highlight['icon'] as IconData,
                color: AppColors.accent,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                highlight['text'] as String,
                style: AppTextStyles.body.copyWith(fontSize: 13),
              ),
            ],
          ),
        );
      }).toList(),
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
    final expertise = [
      {
        'icon': Icons.flutter_dash,
        'title': 'Flutter Development',
        'description': 'Expert in building cross-platform mobile and web applications with Flutter and Dart.',
        'gradient': [AppColors.accent, AppColors.accentPurple],
      },
      {
        'icon': Icons.code,
        'title': 'Java Development',
        'description': 'Proficient in Java programming with experience in full-stack development and backend systems.',
        'gradient': [AppColors.accentPurple, AppColors.accentPink],
      },
      {
        'icon': Icons.storage,
        'title': 'Database Management',
        'description': 'Skilled in MySQL database design, optimization, and management for scalable applications.',
        'gradient': [AppColors.accentPink, AppColors.accent],
      },
      {
        'icon': Icons.web,
        'title': 'Web Technologies',
        'description': 'Experienced in HTML, CSS, JavaScript, Vue.js, and React for modern web development.',
        'gradient': [AppColors.accent, AppColors.accentPurple],
      },
      {
        'icon': Icons.cloud_sync,
        'title': 'Real-time Systems',
        'description': 'Expertise in WebSocket implementation for real-time data communication and live features.',
        'gradient': [AppColors.accentPurple, AppColors.accentPink],
      },
      {
        'icon': Icons.settings,
        'title': 'State Management',
        'description': 'Proficient in Provider, Riverpod, and other state management solutions for Flutter apps.',
        'gradient': [AppColors.accentPink, AppColors.accent],
      },
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 1 : 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: isMobile ? 1.2 : 1.6,
      children: expertise.map((item) {
        return _buildExpertiseCard(
          item['icon'] as IconData,
          item['title'] as String,
          item['description'] as String,
          item['gradient'] as List<Color>,
        );
      }).toList(),
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: gradientColors[0].withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.15),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              title,
              style: AppTextStyles.subHeader.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Expanded(
              child: Text(
                description,
                style: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
