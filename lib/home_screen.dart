import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/widgets/hero_section.dart';
import 'package:my_portfolio/widgets/about_section.dart';
import 'package:my_portfolio/widgets/experience_section.dart';
import 'package:my_portfolio/widgets/skills_section.dart';
import 'package:my_portfolio/widgets/education_section.dart';
import 'package:my_portfolio/widgets/contact_section.dart';
import 'package:my_portfolio/widgets/projects_section.dart';
import 'package:my_portfolio/widgets/scroll_animation_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Global keys for scrolling to sections
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // Full-screen hero section with navigation callbacks
            HeroSection(
              onNavigate: scrollToSection,
              sectionKeys: {
                'About': aboutKey,
                'Services': servicesKey,
                'Skills': skillsKey,
                'Projects': projectsKey,
                'Experience': experienceKey,
                'Contact': contactKey,
              },
            ),
            
            // About section with animation
            ScrollAnimationWrapper(
              animationType: AnimationType.fadeInUp,
              delay: 0.1,
              child: Container(
                key: aboutKey,
                child: const AboutSection(),
              ),
            ),
            
            // Services section with animation
            ScrollAnimationWrapper(
              animationType: AnimationType.scale,
              delay: 0.2,
              child: Container(
                key: servicesKey,
                child: const EducationSection(),
              ),
            ),
            
            // Skills section with animation
            ScrollAnimationWrapper(
              animationType: AnimationType.fadeInLeft,
              delay: 0.2,
              child: Container(
                key: skillsKey,
                child: const SkillsSection(),
              ),
            ),
            
            // Projects section with animation
            ScrollAnimationWrapper(
              animationType: AnimationType.fadeInRight,
              delay: 0.1,
              child: Container(
                key: projectsKey,
                child: const ProjectsSection(),
              ),
            ),
            
            // Experience section with animation
            ScrollAnimationWrapper(
              animationType: AnimationType.fadeInUp,
              delay: 0.1,
              child: Container(
                key: experienceKey,
                child: const ExperienceSection(),
              ),
            ),
            
            // Contact section with animation
            ScrollAnimationWrapper(
              animationType: AnimationType.fadeInUp,
              delay: 0.1,
              child: Container(
                key: contactKey,
                child: const ContactSection(),
              ),
            ),
            
            // Footer with animation
            ScrollAnimationWrapper(
              animationType: AnimationType.fadeIn,
              delay: 0.1,
              child: _buildFooter(),
            ),
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
                      PortfolioData.footerTagline,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        height: 1.6,
                      ),
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
              '© ${DateTime.now().year} ${PortfolioData.name}. Built with Flutter 💙',
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
