import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/resume_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("01. About Me"),
        const SizedBox(height: 30),
        Text(
          ResumeData.about,
          style: AppTextStyles.body,
        ),
        const SizedBox(height: 20),
        Text(
          "Location: ${ResumeData.location}",
          style: AppTextStyles.body.copyWith(color: AppColors.accent),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.subHeader.copyWith(color: AppColors.white)),
        const SizedBox(width: 20),
        const Expanded(child: Divider(color: AppColors.secondary)),
      ],
    );
  }
}
