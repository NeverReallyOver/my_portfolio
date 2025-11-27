/// Portfolio data models and constants
/// Update this file to customize your portfolio content

class PortfolioData {
  // Personal Information
  static const String name = 'Your Name Here';
  static const String title = 'Flutter Developer';
  static const String tagline = 'Available for Mobile & Web Projects';
  static const String description =
      'Passionate Flutter developer crafting beautiful, high-performance mobile and web applications. Specializing in cross-platform development with clean architecture and exceptional user experiences.';
  
  static const String location = 'Your City, Country';
  static const String availability = 'Freelance Available';
  
  // Contact Information
  static const String email = 'your.email@example.com';
  static const String phone = '+1 234 567 8900'; // Optional
  
  // Social Links
  static const String githubUrl = 'https://github.com/yourusername';
  static const String linkedinUrl = 'https://linkedin.com/in/yourusername';
  static const String portfolioUrl = 'https://yourportfolio.com';
  static const String twitterUrl = 'https://twitter.com/yourusername'; // Optional
  
  // Stats
  static const String yearsExperience = '2+';
  static const String projectsCompleted = '10+';
  static const String clientSatisfaction = '100%';
  
  // About Me
  static const String aboutTitle = 'Flutter Development Specialist';
  static const String aboutDescription1 =
      'I\'m a passionate Flutter developer with expertise in building high-quality, cross-platform mobile and web applications. My journey in Flutter development has enabled me to create scalable, performant solutions that deliver exceptional user experiences.';
  
  static const String aboutDescription2 =
      'With a strong focus on clean architecture, state management, and modern development practices, I transform ideas into beautiful, functional applications that work seamlessly across iOS, Android, and Web platforms.';
  
  // Footer
  static const String footerTagline = 'Crafting beautiful Flutter applications\nfor mobile and web';
  
  // TODO: Add more personal information as needed
  // TODO: Add project portfolio items
  // TODO: Add testimonials
  // TODO: Add certifications
}

/// Skills data structure
class SkillData {
  final String name;
  final String category;
  final double level; // 0.0 to 1.0
  final bool isPlaceholder;
  
  const SkillData({
    required this.name,
    required this.category,
    required this.level,
    this.isPlaceholder = false,
  });
}

/// Experience/Project data structure
class ExperienceData {
  final String role;
  final String company;
  final String duration;
  final String description;
  final List<String> achievements;
  final List<String> techStack;
  final bool isCurrent;
  final bool isPlaceholder;
  
  const ExperienceData({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    required this.achievements,
    required this.techStack,
    this.isCurrent = false,
    this.isPlaceholder = false,
  });
}

/// Service offering data structure
class ServiceData {
  final String title;
  final String description;
  final List<String> features;
  
  const ServiceData({
    required this.title,
    required this.description,
    required this.features,
  });
}

// TODO: Add more data structures as needed for:
// - Portfolio projects
// - Testimonials
// - Blog posts
// - Certifications
// - Education
