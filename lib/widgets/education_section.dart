import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

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
                'Services I Offer',
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
              'Professional development services tailored to your needs',
              style: AppTextStyles.body.copyWith(
                fontSize: isMobile ? 14 : 16,
              ),
            ),
          ),
          
          const SizedBox(height: 35),
          
          // Services grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : 4,
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
            childAspectRatio: isMobile ? 1.15 : 0.85,
            children: [
              _buildServiceCard(
                'Flutter Mobile Development',
                'Build cross-platform mobile applications for iOS and Android using Flutter and Dart with native performance.',
                [
                  'Cross-platform development',
                  'State management (Provider/Riverpod)',
                  'UI/UX implementation',
                  'App store deployment',
                ],
                Icons.phone_android,
                [AppColors.accent, AppColors.accentPurple],
              ),
              _buildServiceCard(
                'Web Development',
                'Create responsive and modern web applications using HTML, CSS, JavaScript, Vue.js, and React.',
                [
                  'Responsive design',
                  'Frontend frameworks',
                  'Modern UI/UX',
                  'Performance optimization',
                ],
                Icons.web,
                [AppColors.accentPurple, AppColors.accentPink],
              ),
              _buildServiceCard(
                'Java Backend Development',
                'Full-stack Java development with database integration and RESTful API implementation.',
                [
                  'Java programming',
                  'MySQL database design',
                  'REST API development',
                  'Backend architecture',
                ],
                Icons.code,
                [AppColors.accentPink, AppColors.accent],
              ),
              _buildServiceCard(
                'Real-time Applications',
                'Develop real-time features using WebSocket technology for live data communication.',
                [
                  'WebSocket implementation',
                  'Real-time data sync',
                  'Live notifications',
                  'Interactive features',
                ],
                Icons.cloud_sync,
                [AppColors.accent, AppColors.accentPurple],
              ),
              _buildServiceCard(
                'API Integration',
                'Seamless integration with REST APIs, Firebase, and third-party services for your applications.',
                [
                  'REST API integration',
                  'Firebase services',
                  'Third-party APIs',
                  'Data management',
                ],
                Icons.api,
                [AppColors.accentPurple, AppColors.accentPink],
              ),
              _buildServiceCard(
                'Consultation & Support',
                'Expert consultation and ongoing technical support for your development projects.',
                [
                  'Architecture planning',
                  'Code review',
                  'Technical guidance',
                  'Project support',
                ],
                Icons.support_agent,
                [AppColors.accentPink, AppColors.accent],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    String title,
    String description,
    List<String> features,
    IconData icon,
    List<Color> gradientColors,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: AppDurations.medium,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: gradientColors[0].withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.15),
              blurRadius: 25,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with background effect
            Stack(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradientColors[0].withOpacity(0.2),
                        gradientColors[1].withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                Positioned(
                  top: 3,
                  left: 3,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: gradientColors[0].withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 32),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Title
            Text(
              title,
              style: AppTextStyles.subHeader.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 14),
            
            // Description
            Text(
              description,
              style: AppTextStyles.body.copyWith(
                fontSize: 14,
                height: 1.6,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 20),
            
            // Features - Limited to 3 with scroll if needed
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: features.take(3).map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: gradientColors),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            feature,
                            style: AppTextStyles.body.copyWith(
                              fontSize: 13,
                              height: 1.4,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const Spacer(),
            
            // Get Started button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started',
                      style: AppTextStyles.button.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
