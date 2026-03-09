import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    const exps = PortfolioData.experience;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isMobile),
          const SizedBox(height: 48),

          // Timeline entries
          ...exps.asMap().entries.map(
                (e) => _buildTimelineEntry(
                  e.value,
                  index: e.key,
                  isLast: e.key == exps.length - 1,
                  isMobile: isMobile,
                ),
              ),

          const SizedBox(height: 56),
          _buildEducation(isMobile),
        ],
      ),
    );
  }

  // ── Section header with gradient rule ───────────────────────────────────────

  Widget _buildSectionHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// 05',
          style: AppTextStyles.accent.copyWith(
            color: AppColors.textMuted,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              'Experience',
              style: AppTextStyles.sectionTitle.copyWith(
                fontSize: isMobile ? 28 : 34,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentPurple.withValues(alpha: 0.8),
                      AppColors.accent.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'My professional journey and achievements',
          style: AppTextStyles.body.copyWith(fontSize: 15),
        ),
      ],
    );
  }

  // ── One timeline row (alternating left / right on desktop) ──────────────────

  Widget _buildTimelineEntry(
    Map<String, String> exp, {
    required int index,
    required bool isLast,
    required bool isMobile,
  }) {
    final card = _buildCard(exp, isMobile);
    final dot = _buildDot(exp['current'] == 'true');

    final line = isLast
        ? const SizedBox()
        : Expanded(
            child: Center(
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.border,
                      AppColors.border.withValues(alpha: 0.2),
                    ],
                  ),
                ),
              ),
            ),
          );

    // ── Mobile: left-aligned single-column timeline ──────────────────────────
    if (isMobile) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 28,
              child: Column(children: [dot, line]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
                child: card,
              ),
            ),
          ],
        ),
      );
    }

    // ── Desktop: alternating left / right ────────────────────────────────────
    final isLeft = index.isEven;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left slot
          Expanded(
            child: isLeft
                ? Padding(
                    padding: EdgeInsets.only(
                      right: 28,
                      bottom: isLast ? 0 : 32,
                    ),
                    child: card,
                  )
                : const SizedBox(),
          ),

          // Center timeline
          SizedBox(
            width: 40,
            child: Column(children: [dot, line]),
          ),

          // Right slot
          Expanded(
            child: !isLeft
                ? Padding(
                    padding: EdgeInsets.only(
                      left: 28,
                      bottom: isLast ? 0 : 32,
                    ),
                    child: card,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  // ── Timeline dot ─────────────────────────────────────────────────────────────

  Widget _buildDot(bool isCurrent) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrent ? AppColors.accent : AppColors.surface,
        border: Border.all(
          color: isCurrent ? AppColors.accent : AppColors.border,
          width: 2,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.55),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: isCurrent
          ? null
          : Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.border,
                ),
              ),
            ),
    );
  }

  // ── Experience card ──────────────────────────────────────────────────────────

  Widget _buildCard(Map<String, String> exp, bool isMobile) {
    final isCurrent = exp['current'] == 'true';
    final descLines = (exp['description'] ?? '').split('\n');
    final mainDesc = descLines.first;
    final bullets = descLines
        .skip(1)
        .where((l) => l.trim().isNotEmpty)
        .map((l) => l.replaceAll('• ', '').trim())
        .toList();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent
              ? AppColors.accent.withValues(alpha: 0.3)
              : AppColors.border,
        ),
        boxShadow: isCurrent ? AppShadows.featured : AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Role + company + badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.work_outline,
                  size: 16,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp['role'] ?? '',
                      style: AppTextStyles.subHeader.copyWith(
                        fontSize: isMobile ? 15 : 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      exp['company'] ?? '',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 12,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCurrent) _buildCurrentBadge(),
            ],
          ),

          const SizedBox(height: 12),

          // Period + location with clock icon
          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                size: 13,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                '${exp['period'] ?? ''}  ·  ${exp['location'] ?? ''}',
                style: AppTextStyles.body.copyWith(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            mainDesc,
            style: AppTextStyles.body.copyWith(fontSize: 14, height: 1.7),
          ),

          if (bullets.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Key Responsibilities:',
              style: AppTextStyles.body.copyWith(
                fontSize: 13,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.45),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        b,
                        style: AppTextStyles.body.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCurrentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00D9FF), Color(0xFF7B61FF)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.35),
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        'Current',
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  // ── Education (left-aligned timeline) ───────────────────────────────────────

  Widget _buildEducation(bool isMobile) {
    const edus = PortfolioData.education;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Education',
              style: AppTextStyles.sectionTitle.copyWith(
                fontSize: isMobile ? 22 : 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentGreen.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        ...edus.asMap().entries.map(
              (e) => _buildEduEntry(
                e.value,
                isLast: e.key == edus.length - 1,
                isMobile: isMobile,
              ),
            ),
        if (PortfolioData.courses.isNotEmpty) ...[
          const SizedBox(height: 32),
          Text(
            'Courses',
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 16),
          ...PortfolioData.courses.map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildCourseRow(c),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEduEntry(
    Map<String, String> edu, {
    required bool isLast,
    required bool isMobile,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGreen.withValues(alpha: 0.15),
                    border: Border.all(
                      color: AppColors.accentGreen.withValues(alpha: 0.6),
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.border,
                              AppColors.border.withValues(alpha: 0.2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppShadows.card,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            edu['degree'] ?? '',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            edu['school'] ?? '',
                            style:
                                AppTextStyles.body.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          edu['period'] ?? '',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          edu['score'] ?? '',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 13,
                            color: AppColors.accentGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseRow(Map<String, String> course) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentPurple.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              course['title'] ?? '',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            course['institution'] ?? '',
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
