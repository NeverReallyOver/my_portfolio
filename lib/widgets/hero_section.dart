import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/resume_data.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, my name is",
            style: AppTextStyles.accent,
          ),
          const SizedBox(height: 16),
          Text(
            ResumeData.name,
            style: AppTextStyles.header.copyWith(
              fontSize: 60,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            ResumeData.title,
            style: AppTextStyles.subHeader.copyWith(
              fontSize: 40,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                ResumeData.about,
                style: AppTextStyles.body,
              ),
            ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildSocialButton(FontAwesomeIcons.envelope, ResumeData.socialLinks['Email']!),
              _buildSocialButton(FontAwesomeIcons.phone, ResumeData.socialLinks['Phone']!),
              // Add LinkedIn/GitHub if available
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String url) {
    return IconButton(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      icon: FaIcon(icon, color: AppColors.accent, size: 24),
      style: IconButton.styleFrom(
        side: const BorderSide(color: AppColors.accent),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
