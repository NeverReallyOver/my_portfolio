import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/resume_data.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("03. Skills"),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: ResumeData.skills.map((skill) => _buildSkillChip(skill)).toList(),
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

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.accent),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        skill,
        style: AppTextStyles.accent,
      ),
    );
  }
}
