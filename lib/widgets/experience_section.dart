import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/resume_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("02. Experience"),
        const SizedBox(height: 30),
        ...ResumeData.experience.map((job) => _buildJobCard(job)),
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

  Widget _buildJobCard(Map<String, String> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  job['role']!,
                  style: AppTextStyles.subHeader.copyWith(fontSize: 20, color: AppColors.white),
                ),
              ),
              Text(
                job['period']!,
                style: AppTextStyles.accent,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            job['company']!,
            style: AppTextStyles.body.copyWith(color: AppColors.accent),
          ),
          if (job['location'] != null) ...[
            const SizedBox(height: 4),
            Text(
              job['location']!,
              style: AppTextStyles.body.copyWith(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            job['description']!,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
