import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/constants.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selected = 'All';

  static const _categories = ['All', 'Mobile', 'Web', 'Backend', 'Tools'];

  static const _skills = [
    _Skill('Flutter',   'Mobile',  0xFF00D9FF), // cyan
    _Skill('Dart',      'Mobile',  0xFF00D9FF),
    _Skill('HTML',      'Web',     0xFFFF9500), // orange
    _Skill('CSS',       'Web',     0xFFFF9500),
    _Skill('Vue.js',    'Web',     0xFFFF9500),
    _Skill('React',     'Web',     0xFFFF9500),
    _Skill('Java',      'Backend', 0xFF7B61FF), // purple
    _Skill('MySQL',     'Backend', 0xFF7B61FF),
    _Skill('REST APIs', 'Backend', 0xFF7B61FF),
    _Skill('WebSocket', 'Backend', 0xFF7B61FF),
    _Skill('Git',       'Tools',   0xFF00FF88), // bright green
    _Skill('Firebase',  'Tools',   0xFF00FF88),
    _Skill('Provider',  'Tools',   0xFF00FF88),
    _Skill('Riverpod',  'Tools',   0xFF00FF88),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    final filtered = _selected == 'All'
        ? _skills
        : _skills.where((s) => s.category == _selected).toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isMobile),
          const SizedBox(height: 36),
          _buildCategoryFilter(isMobile),
          const SizedBox(height: 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: filtered.map((s) => _buildSkillTag(s)).toList(),
          ),
          const SizedBox(height: 40),
          _buildNote(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// 03',
          style: AppTextStyles.accent.copyWith(
            color: AppColors.textMuted,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Skills',
          style: AppTextStyles.sectionTitle.copyWith(
            fontSize: isMobile ? 24 : 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Technologies I work with daily',
          style: AppTextStyles.body.copyWith(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((cat) {
          final isSelected = _selected == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => setState(() => _selected = cat),
                child: AnimatedContainer(
                  duration: AppDurations.fast,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accent.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accent.withValues(alpha: 0.5)
                          : AppColors.border,
                    ),
                  ),
                  child: Text(
                    cat,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? AppColors.accent
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

  Widget _buildSkillTag(_Skill skill) {
    final color = Color(skill.colorValue);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        skill.name,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 13,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline,
              size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Primary focus is Flutter & Dart. Java, web frameworks, and tools used in production at current and previous roles.',
              style: AppTextStyles.body.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _Skill {
  final String name;
  final String category;
  final int colorValue;

  const _Skill(this.name, this.category, this.colorValue);
}
