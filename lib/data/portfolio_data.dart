/// Portfolio data models and constants
/// Update this file to customize your portfolio content

class PortfolioData {
  // Personal Information
  static const String name = 'JANAKIRAMAN VELAYUTHAM';
  static const String title = 'Associate Java Developer | Flutter Developer';
  static const String tagline = 'Available for Mobile & Web Projects';
  static const String fullAddress = 'No.14/9, Mangalapuram 1st Street, West Tambaram, Chennai, India';
  static const String description =
      'Associate Java Developer with experience in software and network support. '
      'Skilled in Java development and Flutter mobile development, with expertise in collaboration across diverse teams. '
      'Proficient in troubleshooting and delivering reliable IT solutions.';
  
  static const String location = 'Chennai, India';
  static const String availability = 'Freelance Available';
  
  // Contact Information
  static const String email = 'vjanakiraman03@gmail.com';
  static const String phone = '+91 7401033915';
  
  // Social Links
  static const String githubUrl = 'https://github.com/NeverReallyOver';
  static const String linkedinUrl = 'https://www.linkedin.com/in/janakiraman-velayutham-6507bb208';
  static const String instagramUrl = 'https://janakiraman-portfolio.web.app/';
  static const String resumeUrl = 'https://drive.google.com/file/d/1mmDdBvVHjD62fZEM_xfYCkWxILNzrxpm/view?usp=sharing';
  
  // Stats
  static const String yearsExperience = '1+';
  static const String projectsCompleted = '5+';
  static const String clientSatisfaction = '100%';
  
  // About Me
  static const String aboutTitle = 'Flutter Development Specialist';
  static const String aboutDescription1 =
      'I\'m a passionate Flutter developer with expertise in building high-quality, cross-platform mobile and web applications. My journey in Flutter development has enabled me to create scalable, performant solutions that deliver exceptional user experiences.';
  
  static const String aboutDescription2 =
      'With a strong focus on clean architecture, state management, and modern development practices, I transform ideas into beautiful, functional applications that work seamlessly across iOS, Android, and Web platforms.';
  
  // Skills
  static const List<String> skills = [
    "JAVA", "MySQL", "HTML", "CSS", 
    "Flutter", "Dart", "Vue", "React", 
    "Web Socket",
  ];
  
  // Languages
  static const List<String> languages = [
    "English", "Tamil", "Hindi"
  ];
  
  // Experience
  static const List<Map<String, String>> experience = [
    {
      "role": "Flutter Dev - Intern",
      "company": "ZEBU SHARE AND WEALTH MANAGEMENTS PVT LTD",
      "period": "February 2025 – present",
      "location": "Chennai",
      "description": "Building the UI of a mobile application for Android and iOS",
      "current": "true"
    },
    {
      "role": "ADMIN - EXECUTIVE",
      "company": "CAPRICORN FOOD PRODUCTS INDIA LIMITED",
      "period": "August 2023 – July 2024",
      "location": "Chennai",
      "description": 
          "Collaborated across teams to enhance network performance and user support, boosting system reliability.\n"
          "• Configured LAN and network printers.\n"
          "• Resolved Outlook client issues.\n"
          "• Managed domain configuration and user profiles on Windows Server 2003/2008.\n"
          "• Maintained IT assets and management.\n"
          "• Created and edited documents, reports, and presentations using MS Office Suite.\n"
          "• Managed office supplies inventory for seamless operations"
    },
  ];
  
  // Education
  static const List<Map<String, String>> education = [
    {
      "degree": "B.E (CSE)",
      "school": "ARM COLLEGE OF ENGINEERING AND TECHNOLOGY",
      "period": "2018 – 2022",
      "location": "Maraimalainagar",
      "score": "73.5%"
    },
    {
      "degree": "HSC",
      "school": "KUMARAJAH MUTHIAH HR SEC SCHOOL",
      "period": "2017 – 2018",
      "location": "Chennai",
      "score": "51.5%"
    },
    {
      "degree": "SSLC",
      "school": "SUBHAM VIDHYALAYA CBSE SCHOOL",
      "period": "2015 – 2016",
      "location": "Maduranthakam",
      "score": "70.0%"
    }
  ];
  
  // Courses
  static const List<Map<String, String>> courses = [
    {
      "title": "JAVA FULL STACK",
      "institution": "PUMO TECHNOVATION",
      "period": "July 2024",
      "location": "CHENNAI"
    }
  ];
  
  // Projects
  static const List<Map<String, String>> projects = [
    {
      "title": "Portfolio Website",
      "description": "A personal portfolio website built with Flutter and hosted on Firebase.",
      "link": "https://janakiraman-portfolio.web.app/"
    },
  ];
  
  // Social Links Map
  static const Map<String, String> socialLinks = {
    "Email": "mailto:$email",
    "Phone": "tel:$phone",
    "LinkedIn": linkedinUrl,
    "GitHub": githubUrl,
  };
  
  // Footer
  static const String footerTagline = 'Crafting beautiful Flutter applications\nfor mobile and web';
}

/// Skills data structure for detailed skill representation
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

/// Project data structure
class ProjectData {
  final String title;
  final String description;
  final String? link;
  final List<String>? techStack;
  final String? imageUrl;
  
  const ProjectData({
    required this.title,
    required this.description,
    this.link,
    this.techStack,
    this.imageUrl,
  });
}

/// Education data structure
class EducationData {
  final String degree;
  final String school;
  final String period;
  final String location;
  final String score;
  
  const EducationData({
    required this.degree,
    required this.school,
    required this.period,
    required this.location,
    required this.score,
  });
}
