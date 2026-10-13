import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/main.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  // Renders the whole page at phone, tablet and desktop widths. Any layout
  // overflow surfaces as a test failure.
  for (final width in [375.0, 820.0, 1440.0]) {
    testWidgets('page lays out at ${width.toInt()} px', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const PortfolioApp());
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('I build real-time trading apps in Flutter.'),
          findsOneWidget);
      expect(find.text('Mynt: a real-time trading app'), findsOneWidget);

      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -20000));
      await tester.pump(const Duration(milliseconds: 400));
      expect(
          find.textContaining('Hiring a Flutter developer?'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
    });
  }
}
