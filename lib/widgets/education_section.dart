import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/resume_data.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("04. Education"),
        const SizedBox(height: 30),
        ...ResumeData.education.map((edu) => _buildEduCard(edu)),
        if (ResumeData.courses.isNotEmpty) ...[
          const SizedBox(height: 30),
          Text("Courses", style: AppTextStyles.subHeader.copyWith(fontSize: 20)),
          const SizedBox(height: 20),
          ...ResumeData.courses.map((course) => _buildCourseCard(course)),
        ]
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

  Widget _buildEduCard(Map<String, String> edu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.school, color: AppColors.accent, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu['degree']!,
                  style: AppTextStyles.subHeader.copyWith(fontSize: 18, color: AppColors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  edu['school']!,
                  style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(edu['period']!, style: AppTextStyles.accent),
                    if (edu['score'] != null) ...[
                      const SizedBox(width: 10),
                      Text("• Score: ${edu['score']}", style: AppTextStyles.body),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Map<String, String> course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.book, color: AppColors.accent, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title']!,
                  style: AppTextStyles.subHeader.copyWith(fontSize: 18, color: AppColors.white),
                ),
                Text(
                  "${course['institution']} | ${course['period']}",
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
