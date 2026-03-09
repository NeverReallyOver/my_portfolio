import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/widgets/nav_bar.dart';
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
  final GlobalKey aboutKey      = GlobalKey();
  final GlobalKey servicesKey   = GlobalKey();
  final GlobalKey skillsKey     = GlobalKey();
  final GlobalKey projectsKey   = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey contactKey    = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Map<String, GlobalKey> get _sectionKeys => {
    'About':      aboutKey,
    'Services':   servicesKey,
    'Skills':     skillsKey,
    'Projects':   projectsKey,
    'Experience': experienceKey,
    'Contact':    contactKey,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Scrollable page content ──────────────────────────────────
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                HeroSection(
                  onNavigate: scrollToSection,
                  sectionKeys: _sectionKeys,
                ),

                ScrollAnimationWrapper(
                  animationType: AnimationType.fadeInUp,
                  delay: 0.1,
                  child: Container(key: aboutKey, child: const AboutSection()),
                ),

                ScrollAnimationWrapper(
                  animationType: AnimationType.scale,
                  delay: 0.2,
                  child: Container(key: servicesKey, child: const EducationSection()),
                ),

                ScrollAnimationWrapper(
                  animationType: AnimationType.fadeInLeft,
                  delay: 0.2,
                  child: Container(key: skillsKey, child: const SkillsSection()),
                ),

                ScrollAnimationWrapper(
                  animationType: AnimationType.fadeInRight,
                  delay: 0.1,
                  child: Container(key: projectsKey, child: const ProjectsSection()),
                ),

                ScrollAnimationWrapper(
                  animationType: AnimationType.fadeInUp,
                  delay: 0.1,
                  child: Container(key: experienceKey, child: const ExperienceSection()),
                ),

                ScrollAnimationWrapper(
                  animationType: AnimationType.fadeInUp,
                  delay: 0.1,
                  child: Container(key: contactKey, child: const ContactSection()),
                ),

                ScrollAnimationWrapper(
                  animationType: AnimationType.fadeIn,
                  delay: 0.1,
                  child: _buildFooter(),
                ),
              ],
            ),
          ),

          // ── Fixed navbar overlay ─────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              onNavigate: scrollToSection,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 80),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© ${DateTime.now().year} Janakiraman Velayutham',
            style: AppTextStyles.body.copyWith(fontSize: 13),
          ),
          Text(
            'Built with Flutter',
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
