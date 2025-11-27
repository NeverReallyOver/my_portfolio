import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Janakiraman Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.primary,
        colorScheme: ColorScheme.dark(
          primary: AppColors.accent,
          secondary: AppColors.secondary,
          surface: AppColors.primary,
          onSurface: AppColors.textPrimary,
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
