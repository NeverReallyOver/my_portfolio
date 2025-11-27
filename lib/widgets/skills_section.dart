import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String selectedCategory = 'All';
  
  final categories = ['All', 'Mobile', 'Web', 'Backend', 'Tools'];
  
  final skills = [
    {'name': 'Flutter', 'category': 'Mobile', 'level': 0.95, 'icon': Icons.flutter_dash},
    {'name': 'Dart', 'category': 'Mobile', 'level': 0.90, 'icon': Icons.code},
    {'name': 'Firebase', 'category': 'Backend', 'level': 0.85, 'icon': Icons.cloud},
    {'name': 'REST APIs', 'category': 'Backend', 'level': 0.90, 'icon': Icons.api},
    {'name': 'State Management', 'category': 'Mobile', 'level': 0.88, 'icon': Icons.settings},
    {'name': 'Responsive Design', 'category': 'Web', 'level': 0.92, 'icon': Icons.devices},
    {'name': 'Git', 'category': 'Tools', 'level': 0.85, 'icon': Icons.source},
    {'name': 'UI/UX Design', 'category': 'Web', 'level': 0.80, 'icon': Icons.palette},
    // Placeholder for future skills
    {'name': 'GraphQL', 'category': 'Backend', 'level': 0.70, 'icon': Icons.api, 'placeholder': true},
    {'name': 'CI/CD', 'category': 'Tools', 'level': 0.75, 'icon': Icons.build, 'placeholder': true},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    final filteredSkills = selectedCategory == 'All'
        ? skills
        : skills.where((s) => s['category'] == selectedCategory).toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 70,
      ),
      child: Column(
        children: [
          // Section header
          Column(
            children: [
              Text(
                'Technologies I Master',
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: isMobile ? 32 : 40,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              Text(
                'A comprehensive toolkit of modern technologies and frameworks',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 35),
              
              // Category filter
              _buildCategoryFilter(isMobile),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // Skills grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: isMobile ? 0.9 : 1.6,
            ),
            itemCount: filteredSkills.length,
            itemBuilder: (context, index) {
              final skill = filteredSkills[index];
              return _buildSkillCard(
                skill['name'] as String,
                skill['level'] as double,
                skill['icon'] as IconData,
                isPlaceholder: skill['placeholder'] == true,
              );
            },
          ),
          
          const SizedBox(height: 40),
          
          // Note about adding more skills
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.accentPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.accentPurple.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.accentPurple,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Always learning and expanding my tech stack. More skills coming soon!',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.accentPurple,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categories.map((category) {
          final isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                child: AnimatedContainer(
                  duration: AppDurations.medium,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [AppColors.accent, AppColors.accentPurple],
                          )
                        : null,
                    color: isSelected ? null : AppColors.cardBg,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : AppColors.accent.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    category,
                    style: AppTextStyles.button.copyWith(
                      fontSize: 14,
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSkillCard(String name, double level, IconData icon,
      {bool isPlaceholder = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: AppDurations.medium,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPlaceholder
                ? AppColors.accentPurple.withOpacity(0.3)
                : AppColors.accent.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.05),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isPlaceholder
                      ? [AppColors.accentPurple, AppColors.accentPink]
                      : [AppColors.accent, AppColors.accentPurple],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            
            const SizedBox(height: 12),
            
            // Skill name
            Text(
              name,
              style: AppTextStyles.subHeader.copyWith(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 10),
            
            // Progress bar
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1500),
              tween: Tween(begin: 0.0, end: level),
              builder: (context, value, child) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: value,
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.accent,
                                  AppColors.accentPurple,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(value * 100).toInt()}%',
                      style: AppTextStyles.accent.copyWith(fontSize: 12),
                    ),
                  ],
                );
              },
            ),
            
            if (isPlaceholder) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Learning',
                  style: AppTextStyles.accent.copyWith(
                    fontSize: 10,
                    color: AppColors.accentPurple,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
