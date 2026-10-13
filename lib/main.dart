import 'package:flutter/material.dart';
import 'package:my_portfolio/home_screen.dart';
import 'package:my_portfolio/theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Janakiraman Velayutham · Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const HomeScreen(),
    );
  }
}
