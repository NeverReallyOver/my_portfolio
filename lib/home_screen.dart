import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/hero_section.dart';
import 'package:my_portfolio/widgets/profile_sections.dart';
import 'package:my_portfolio/widgets/project_form.dart';
import 'package:my_portfolio/widgets/proof_strip.dart';
import 'package:my_portfolio/widgets/top_bar.dart';
import 'package:my_portfolio/widgets/work_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scroll = ScrollController();
  final _keys = {
    'Work': GlobalKey(),
    'Experience': GlobalKey(),
    'About': GlobalKey(),
    'Freelance': GlobalKey(),
    'Contact': GlobalKey(),
  };
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    // A link ending in ?project opens the project form directly, for sharing
    // with prospective clients.
    if (Uri.base.queryParameters.containsKey('project')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showProjectForm(context);
      });
    }
    _scroll.addListener(() {
      final scrolled = _scroll.offset > 8;
      if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _goTo(String section) {
    if (section == 'top') {
      _scroll.animateTo(0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic);
      return;
    }
    final ctx = _keys[section]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scroll,
            child: Column(
              children: [
                const SizedBox(height: 64),
                HeroSection(onSeeWork: () => _goTo('Work')),
                const ProofStrip(),
                KeyedSubtree(key: _keys['Work'], child: const WorkSection()),
                KeyedSubtree(
                    key: _keys['Experience'], child: const ExperienceSection()),
                KeyedSubtree(
                    key: _keys['About'], child: const SkillsAboutSection()),
                KeyedSubtree(
                    key: _keys['Freelance'], child: const FreelanceSection()),
                KeyedSubtree(
                    key: _keys['Contact'], child: const ContactSection()),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopBar(
                scrolled: _scrolled,
                sections: _keys.keys.toList(),
                onNavigate: _goTo),
          ),
        ],
      ),
    );
  }
}
