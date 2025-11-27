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
            const HeroSection(),
            _buildSection(const AboutSection()),
            _buildSection(const ExperienceSection()),
            _buildSection(const SkillsSection()),
            _buildSection(const EducationSection()),
            _buildSection(const ContactSection()),
            const SizedBox(height: 50),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(Widget child) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: child,
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.secondary,
      width: double.infinity,
      child: Center(
        child: Text(
          "© 2025 Janakiraman Velayutham. Built with Flutter.",
          style: AppTextStyles.body.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
