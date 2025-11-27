import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/widgets/hero_section.dart';
import 'package:my_portfolio/widgets/about_section.dart';
import 'package:my_portfolio/widgets/experience_section.dart';
import 'package:my_portfolio/widgets/skills_section.dart';
import 'package:my_portfolio/widgets/education_section.dart';
import 'package:my_portfolio/widgets/contact_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Full-screen hero section
            const HeroSection(),
            
            // About section
            const AboutSection(),
            
            // Skills section
            const SkillsSection(),
            
            // Experience section
            const ExperienceSection(),
            
            // Services section
            const EducationSection(),
            
            // Contact section
            const ContactSection(),
            
            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondary,
            AppColors.primary,
          ],
        ),
      ),
      child: Column(
        children: [
          // Footer content
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.accent, AppColors.accentPurple],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.flutter_dash,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Flutter Developer',
                          style: AppTextStyles.button.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Crafting beautiful Flutter applications\nfor mobile and web',
                      style: AppTextStyles.body.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withOpacity(0),
                  AppColors.accent.withOpacity(0.3),
                  AppColors.accent.withOpacity(0),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Copyright
          Center(
            child: Text(
              '© ${DateTime.now().year} Your Name. Built with Flutter 💙',
              style: AppTextStyles.body.copyWith(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
