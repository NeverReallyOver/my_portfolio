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
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          // Section header
          Column(
            children: [
              Text(
                'Services I Offer',
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: isMobile ? 32 : 40,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              Text(
                'Professional Flutter development services tailored to your needs',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          
          const SizedBox(height: 50),
          
          // Services grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            childAspectRatio: isMobile ? 1.1 : 0.85,
            children: [
              _buildServiceCard(
                'Mobile App Development',
                'Native iOS and Android apps using Flutter with top-tier performance and native feel.',
                [
                  'Cross-platform development',
                  'Native performance',
                  'App/Play Store deployment',
                  'Ongoing maintenance',
                ],
                Icons.phone_android,
                [AppColors.accent, AppColors.accentPurple],
              ),
              _buildServiceCard(
                'Web Application Development',
                'Modern, responsive web applications built with Flutter Web for seamless user experience.',
                [
                  'Responsive design',
                  'PWA development',
                  'SEO optimization',
                  'Fast loading times',
                ],
                Icons.web,
                [AppColors.accentPurple, AppColors.accentPink],
              ),
              _buildServiceCard(
                'UI/UX Implementation',
                'Pixel-perfect implementation of designs with smooth animations and interactions.',
                [
                  'Design to code',
                  'Custom animations',
                  'Micro-interactions',
                  'Accessibility compliance',
                ],
                Icons.design_services,
                [AppColors.accentPink, AppColors.accent],
              ),
              _buildServiceCard(
                'API Integration & Backend',
                'Seamless integration with REST APIs, Firebase, and third-party services.',
                [
                  'REST API integration',
                  'Firebase setup',
                  'Real-time features',
                  'Cloud functions',
                ],
                Icons.cloud_sync,
                [AppColors.accent, AppColors.accentPurple],
              ),
              _buildServiceCard(
                'App Optimization',
                'Performance tuning and optimization for faster, smoother applications.',
                [
                  'Performance profiling',
                  'Code optimization',
                  'Bundle size reduction',
                  'Memory management',
                ],
                Icons.speed,
                [AppColors.accentPurple, AppColors.accentPink],
              ),
              _buildServiceCard(
                'Consultation & Support',
                'Expert Flutter consultation and ongoing technical support for your projects.',
                [
                  'Architecture planning',
                  'Code review',
                  'Technical guidance',
                  '24/7 support',
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
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: gradientColors[0].withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 35),
            ),
            
            const SizedBox(height: 20),
            
            // Title
            Text(
              title,
              style: AppTextStyles.subHeader.copyWith(fontSize: 20),
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Text(
              description,
              style: AppTextStyles.body.copyWith(fontSize: 14),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 20),
            
            // Features
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: gradientColors[0],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            feature,
                            style: AppTextStyles.body.copyWith(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Get Started button
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: AppTextStyles.button.copyWith(fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
