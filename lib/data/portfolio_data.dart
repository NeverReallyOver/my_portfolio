/// Portfolio data models and constants
/// Update this file to customize your portfolio content

class PortfolioData {
  // Personal Information
  static const String name = 'JANAKIRAMAN VELAYUTHAM';
  static const String title = 'Freelance Flutter Developer';
  static const String tagline = 'Available for Mobile & Web Projects';
  static const String fullAddress = 'No.14/9, Mangalapuram 1st Street, West Tambaram, Chennai, India';
  static const String description =
      'I\'m a passionate Flutter developer specializing in creating beautiful, high-performance cross-platform applications. '
      'With expertise in mobile and web development, I help businesses transform their ideas into stunning digital experiences. '
      'I focus on clean code, modern UI/UX design, and delivering solutions that exceed expectations.';
  
  static const String location = 'Chennai, India';
  static const String availability = 'Available for Freelance Projects';
  
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
  static const String aboutTitle = 'Freelance Flutter Developer';
  static const String aboutDescription1 =
      'I transform your ideas into stunning, high-performance mobile and web applications. As a freelance Flutter developer, I specialize in creating cross-platform solutions that work seamlessly on iOS, Android, and Web.';
  
  static const String aboutDescription2 =
      'My approach combines modern UI/UX design principles with clean, maintainable code. I work closely with clients to understand their vision and deliver solutions that not only meet but exceed expectations. Whether you need a complete app from scratch or enhancements to existing projects, I\'m here to help.';
  
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
      "role": "Mobile App Developer",
      "company": "Zebu Share And Wealth Managements Pvt Ltd",
      "period": "Feb 2024 – Present",
      "location": "Chennai",
      "description": 
          "Leading mobile app development for MYNT trading platform using Flutter and Dart.\n"
          "• Redesigned MYNT trading app UI using Flutter and Dart.\n"
          "• Built Pay-off and Portfolio feature for multi‑stock management.\n"
          "• Led mobile‑to‑web conversion to expand accessibility.\n"
          "• Integrated RESTful APIs and models for real‑time data.\n"
          "• Optimized performance using Provider and Riverpod.",
      "current": "true"
    },
    // {
    //   "role": "UI Designer – Intern",
    //   "company": "NETAXIS IT SOLUTIONS PRIVATE LIMITED",
    //   "period": "Nov 2023 – May 2024",
    //   "location": "Chennai",
    //   "description": 
    //       "Developed responsive web interfaces and trained in modern UI design technologies.\n"
    //       "• Trained in UI design: HTML, SCSS, Bootstrap, JavaScript.\n"
    //       "• Developed responsive web interfaces."
    // },
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
      "title": "MYNT Trading Platform",
      "description": "Redesigned and developed a comprehensive trading platform mobile app using Flutter. Features include real-time portfolio management, multi-stock tracking, and seamless web integration.",
      "link": "",
      "tech": "Flutter, Dart, REST APIs, Provider, Riverpod",
      "type": "Mobile App"
    },
    {
      "title": "Portfolio Website",
      "description": "A modern, responsive portfolio website built with Flutter Web, showcasing professional work and services with smooth animations and modern UI.",
      "link": "https://janakiraman-portfolio.web.app/",
      "tech": "Flutter Web, Firebase Hosting",
      "type": "Web App"
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
  static const String footerTagline = 'Ready to bring your ideas to life?\nLet\'s create something amazing together!';
  
  // Services for Freelancing
  static const List<Map<String, dynamic>> services = [
    {
      "title": "Flutter Mobile Development",
      "description": "Build native-quality iOS and Android apps with a single codebase",
      "features": ["Cross-platform development", "State management", "UI/UX design", "App store deployment"],
      "icon": "phone_android"
    },
    {
      "title": "Flutter Web Development",
      "description": "Create responsive, fast web applications with Flutter Web",
      "features": ["Responsive design", "Performance optimization", "Modern UI/UX", "SEO friendly"],
      "icon": "web"
    },
    {
      "title": "UI/UX Design & Implementation",
      "description": "Beautiful, intuitive interfaces that users love",
      "features": ["Custom UI design", "Material Design", "Animations", "User experience"],
      "icon": "palette"
    },
    {
      "title": "API Integration",
      "description": "Seamless integration with REST APIs and third-party services",
      "features": ["REST API integration", "Firebase services", "Real-time data", "Authentication"],
      "icon": "api"
    },
    {
      "title": "App Maintenance & Support",
      "description": "Ongoing support and updates for your applications",
      "features": ["Bug fixes", "Feature updates", "Performance optimization", "Technical support"],
      "icon": "support_agent"
    },
    {
      "title": "Consultation & Code Review",
      "description": "Expert guidance for your Flutter projects",
      "features": ["Architecture planning", "Code review", "Best practices", "Technical guidance"],
      "icon": "code"
    },
  ];
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
