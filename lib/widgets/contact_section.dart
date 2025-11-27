import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/resume_data.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Text(
            "05. What's Next?",
            style: AppTextStyles.accent,
          ),
          const SizedBox(height: 20),
          Text(
            "Get In Touch",
            style: AppTextStyles.header.copyWith(fontSize: 40, color: AppColors.white),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "I'm currently looking for new opportunities. Whether you have a question or just want to say hi, I'll try my best to get back to you!",
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse("mailto:${ResumeData.email}");
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.accent,
              side: const BorderSide(color: AppColors.accent),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              textStyle: AppTextStyles.accent.copyWith(fontSize: 16),
            ),
            child: const Text("Say Hello"),
          ),
        ],
      ),
    );
  }
}
