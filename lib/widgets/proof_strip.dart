import 'package:flutter/material.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/theme.dart';
import 'package:my_portfolio/widgets/common.dart';

/// Four numbers a reviewer can verify, set like a ledger between hairlines.
class ProofStrip extends StatelessWidget {
  const ProofStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final size = screenSizeOf(context);
    final columns = size == ScreenSize.desktop ? 4 : 2;

    return ContentWidth(
      child: Container(
        decoration: const BoxDecoration(
          border:
              Border.symmetric(horizontal: BorderSide(color: Palette.hairline)),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cellWidth = constraints.maxWidth / columns;
            return Wrap(
              children: [
                for (var i = 0; i < stats.length; i++)
                  _Cell(
                    stat: stats[i],
                    width: cellWidth,
                    leftRule: i % columns != 0,
                    topRule: i >= columns,
                    compact: size == ScreenSize.mobile,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell(
      {required this.stat,
      required this.width,
      required this.leftRule,
      required this.topRule,
      required this.compact});

  final Stat stat;
  final double width;
  final bool leftRule;
  final bool topRule;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(leftRule ? (compact ? 16 : 28) : 0,
          compact ? 22 : 30, compact ? 12 : 24, compact ? 22 : 30),
      decoration: BoxDecoration(
        border: Border(
          left: leftRule
              ? const BorderSide(color: Palette.hairline)
              : BorderSide.none,
          top: topRule
              ? const BorderSide(color: Palette.hairline)
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stat.value, style: Fonts.number(compact ? 30 : 40)),
          const SizedBox(height: 10),
          Text(stat.caption,
              style: Fonts.body(
                  size: compact ? 13.5 : 14.5, color: Palette.muted)),
        ],
      ),
    );
  }
}
