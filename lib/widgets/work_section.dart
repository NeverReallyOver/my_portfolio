import 'package:flutter/material.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/theme.dart';
import 'package:my_portfolio/widgets/common.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    final gap = size == ScreenSize.mobile ? 56.0 : 88.0;
    return ContentWidth(
      vertical: gap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '01',
            label: 'Selected work',
            title: 'Production apps people use for their money.',
          ),
          SizedBox(height: size == ScreenSize.mobile ? 40 : 56),
          const _MyntCase(),
          SizedBox(height: gap),
          const _WorkProjects(),
          SizedBox(height: gap),
          const _SideProjects(),
        ],
      ),
    );
  }
}

class _MyntCase extends StatelessWidget {
  const _MyntCase();

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    final wide = size == ScreenSize.desktop;

    final built = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('WHAT I BUILT', style: Fonts.label()),
        const SizedBox(height: 16),
        for (final item in Mynt.built) DashItem(item),
      ],
    );

    final security = _NoteBlock(
      title: Mynt.securityTitle,
      child: Column(
          children: [for (final s in Mynt.security) DashItem(s, size: 15)]),
    );

    final shipping = _NoteBlock(
      title: Mynt.releaseTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Mynt.release, style: Fonts.body(size: 15)),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 24,
            runSpacing: 8,
            children: [
              TextLink(label: 'Mynt on Google Play', url: Profile.myntPlayUrl),
              TextLink(label: 'Mynt web app', url: Profile.myntWebUrl),
            ],
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Mynt.title,
            style: Fonts.title(size == ScreenSize.mobile ? 26 : 32)),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(Mynt.summary, style: Fonts.body(size: 17)),
        ),
        const SizedBox(height: 28),
        const _MetaRow(meta: Mynt.meta),
        const SizedBox(height: 40),
        if (wide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: built),
              const SizedBox(width: 56),
              const Expanded(flex: 6, child: _PerfPanel()),
            ],
          )
        else ...[
          built,
          const SizedBox(height: 32),
          const _PerfPanel(),
        ],
        const SizedBox(height: 40),
        if (wide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: security),
              const SizedBox(width: 56),
              Expanded(child: shipping),
            ],
          )
        else ...[
          security,
          const SizedBox(height: 28),
          shipping,
        ],
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.meta});

  final Map<String, String> meta;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 16,
      children: [
        for (final e in meta.entries)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(e.key.toUpperCase(), style: Fonts.label(size: 11)),
              const SizedBox(height: 4),
              Text(e.value,
                  style: Fonts.body(
                      size: 15, color: Palette.ink, weight: FontWeight.w500)),
            ],
          ),
      ],
    );
  }
}

class _PerfPanel extends StatelessWidget {
  const _PerfPanel();

  @override
  Widget build(BuildContext context) {
    final mobile = screenSizeOf(context) == ScreenSize.mobile;
    return Container(
      padding: EdgeInsets.all(mobile ? 20 : 28),
      decoration: BoxDecoration(
        color: Palette.paperRaised,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Palette.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Mynt.perfTitle, style: Fonts.title(22)),
          const SizedBox(height: 10),
          Text(Mynt.perfBody, style: Fonts.body(size: 15)),
          const SizedBox(height: 24),
          Row(
            children: [
              _legend(Palette.hairline, 'Before'),
              const SizedBox(width: 18),
              _legend(Palette.accent, 'After'),
            ],
          ),
          const SizedBox(height: 16),
          for (final m in Mynt.perf) _Bars(measure: m),
          const SizedBox(height: 4),
          Text(Mynt.perfNote, style: Fonts.label(size: 11)),
        ],
      ),
    );
  }

  Widget _legend(Color color, String text) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 6),
        Text(text, style: Fonts.label(size: 11)),
      ],
    );
  }
}

class _Bars extends StatelessWidget {
  const _Bars({required this.measure});

  final Measure measure;

  @override
  Widget build(BuildContext context) {
    final ratio = (measure.after / measure.before).clamp(0.02, 1.0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(measure.label,
                      style: Fonts.body(size: 14, color: Palette.ink))),
              Text(measure.beforeText,
                  style: Fonts.number(13, color: Palette.muted)),
              Text('  →  ', style: Fonts.label(size: 12)),
              Text(measure.afterText,
                  style: Fonts.number(13, color: Palette.accent)),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, c) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 6,
                    width: c.maxWidth,
                    decoration: _bar(Palette.hairline)),
                const SizedBox(height: 4),
                Container(
                    height: 6,
                    width: c.maxWidth * ratio,
                    decoration: _bar(Palette.accent)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _bar(Color color) =>
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(3));
}

class _NoteBlock extends StatelessWidget {
  const _NoteBlock({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Palette.ink, width: 1.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Fonts.title(20)),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _WorkProjects extends StatelessWidget {
  const _WorkProjects();

  @override
  Widget build(BuildContext context) {
    final perRow = switch (screenSizeOf(context)) {
      ScreenSize.mobile => 1,
      ScreenSize.tablet => 2,
      ScreenSize.desktop => 3,
    };
    final cards = [for (final p in workProjects) _ProjectCard(project: p)];
    final rows = [
      for (var i = 0; i < cards.length; i += perRow)
        cards.sublist(i, (i + perRow).clamp(0, cards.length)),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ALSO AT ZEBU', style: Fonts.label()),
        const SizedBox(height: 20),
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            // Equal-height cards per row; empty slots keep column widths.
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < perRow; i++) ...[
                    if (i > 0) const SizedBox(width: 24),
                    Expanded(child: i < row.length ? row[i] : const SizedBox()),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Palette.paperRaised,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Palette.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project.kind.toUpperCase(),
              style: Fonts.label(size: 11, color: Palette.accent)),
          const SizedBox(height: 10),
          Text(project.title, style: Fonts.title(24)),
          const SizedBox(height: 12),
          Text(project.body, style: Fonts.body(size: 15.5)),
          const SizedBox(height: 18),
          for (final f in project.facts) DashItem(f, size: 15),
          const SizedBox(height: 8),
          Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final s in project.stack) Tag(s)]),
        ],
      ),
    );
  }
}

class _SideProjects extends StatelessWidget {
  const _SideProjects();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FREELANCE AND SIDE PROJECTS', style: Fonts.label()),
        const SizedBox(height: 8),
        for (final p in sideProjects) _SideRow(project: p),
        const Hairline(),
      ],
    );
  }
}

class _SideRow extends StatelessWidget {
  const _SideRow({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final wide = screenSizeOf(context) == ScreenSize.desktop;
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.title,
            style: Fonts.body(
                size: 17, color: Palette.ink, weight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(project.kind, style: Fonts.label(size: 11.5)),
      ],
    );
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.body, style: Fonts.body(size: 15)),
        const SizedBox(height: 12),
        Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [for (final s in project.stack) Tag(s)]),
      ],
    );
    final trailing = project.url == null
        ? const SizedBox.shrink()
        : TextLink(label: project.urlLabel ?? 'Link', url: project.url!);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Palette.hairline))),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 260, child: heading),
                const SizedBox(width: 32),
                Expanded(child: body),
                const SizedBox(width: 32),
                SizedBox(
                    width: 80,
                    child:
                        Align(alignment: Alignment.topRight, child: trailing)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading,
                const SizedBox(height: 10),
                body,
                if (project.url != null) ...[
                  const SizedBox(height: 14),
                  trailing
                ],
              ],
            ),
    );
  }
}
