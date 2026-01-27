/// Portfolio data constants extracted from CV
class PortfolioData {
  PortfolioData._();

  // Profile Information
  static const String fullName = 'Hajar Salamah';
  static const String title = 'Mobile App Developer';
  static const String location = 'Sana\'a | Yemen';
  static const String email = 'salamprogramer@gmail.com';
  static const String phone = '+967771019495';
  static const String githubUsername = 'HajarSalamah-Developer';
  static const String githubUrl = 'https://github.com/HajarSalamah-Developer';
  static const String githubAlt = 'github.com/SlamiHajar';
  static const String githubAltUrl = 'https://github.com/SlamiHajar';

  // Profile Summary
  static const String profileSummary =
      'Mobile app developer with 4+ years of experience delivering high-performance Flutter and Android (Java/Kotlin) applications. Specialized in Clean Architecture, scalable codebases, and seamless integrations with Firebase, REST APIs, and MySQL. Skilled in building reliable CI/CD pipelines and managing project workflows through GitHub and JIRA. Strong problem-solver with a consistent record of shipping clean, stable, production-ready apps.\n\nSeeking a professional team where real impact and technical growth matter.';

  // Experience Data
  static const List<Map<String, dynamic>> experiences = [
    {
      'period': '2024 – Present',
      'company': 'Developers Options Company',
      'location': 'Yemen',
      'position': 'Mobile App Developer',
      'responsibilities': [
        'Develop Flutter and Android applications within the mobile team at Developer Options',
        'Improved app performance by ~25% through optimized state management and caching',
        'Integrated Firebase, REST APIs, push notifications, and real-time features',
        'Contributed to architecture decisions and code quality improvements',
      ],
    },
    {
      'period': '2023-2024',
      'company': 'Freelance Android',
      'location': 'Yemen',
      'position': 'Mobile App Developer (Remote)',
      'responsibilities': [
        'Delivered complete applications including UI, logic, backend integration, and deployment',
      ],
    },
    {
      'period': '2022-2023',
      'company': 'NetCoin Company',
      'location': 'Yemen',
      'position': 'Mobile App Developer',
      'responsibilities': [
        'Developed native Android applications using Kotlin & Java',
        'Implemented authentication flows and REST API integrations',
        'Reduced app crash rate by ~30% by improving code structure',
      ],
    },
  ];

  // Education Data
  static const List<Map<String, dynamic>> education = [
    {
      'period': '2020 – 2021',
      'institution': 'Coding Academy (Powered by Rowad)',
      'degree': 'Android App Bootcamp',
      'location': '',
    },
    {
      'period': '10.2015 - 08.2019',
      'institution': 'Sana\'a University',
      'degree': 'Bachelor\'s Degree in Computer Science',
      'grade': 'Grade: 87.4%',
      'location': '',
    },
    {
      'period': '2014 - 2015',
      'institution': 'British Academic Institute',
      'degree': 'Diploma in English',
      'grade': 'Grade: 92%',
      'location': '',
    },
  ];

  // Skills Data
  static const Map<String, List<Map<String, dynamic>>> skills = {
    'Programming Languages': [
      {'name': 'Dart & Flutter', 'level': 0.95},
      {'name': 'Kotlin & Java (Android)', 'level': 0.90},
      {'name': 'Python', 'level': 0.70},
      {'name': 'C++', 'level': 0.65},
      {'name': 'PHP', 'level': 0.60},
      {'name': 'C#', 'level': 0.55},
      {'name': 'Linux', 'level': 0.70},
    ],
    'Databases': [
      {'name': 'SQL/MySQL', 'level': 0.85},
    ],
    'Technologies & Tools': [
      {'name': 'Git/GitHub', 'level': 0.90},
      {'name': 'Firebase', 'level': 0.90},
      {'name': 'RESTful APIs, SOAP, WebSockets', 'level': 0.85},
      {'name': 'JIRA', 'level': 0.80},
      {'name': 'CI/CD Pipelines', 'level': 0.75},
    ],
    'Productivity Tools': [
      {'name': 'MS-Word, Excel, PowerPoint, Access', 'level': 0.85},
    ],
    'Web': [
      {'name': 'HTML, CSS, Bootstrap', 'level': 0.80},
    ],
    'Software Engineering': [
      {'name': 'Clean Architecture', 'level': 0.90},
      {'name': 'Object-Oriented Programming', 'level': 0.95},
      {'name': 'Problem Solving', 'level': 0.90},
      {'name': 'Complex Decision Making', 'level': 0.85},
      {'name': 'Project Management', 'level': 0.80},
      {'name': 'Service-Focused Development', 'level': 0.85},
      {'name': 'High Organizational Capacity', 'level': 0.85},
      {'name': 'Strong Communication', 'level': 0.90},
    ],
    'Language Skills': [
      {'name': 'Arabic: Native speaker', 'level': 1.0},
      {
        'name': 'English: Business fluent, technical correspondence',
        'level': 0.90,
      },
    ],
  };

  // Projects Data
  static const List<Map<String, dynamic>> projects = [
    {
      'name': 'Dental Store',
      'description':
          'Google Play: A comprehensive dental store application for managing dental products and services.',
      'playStoreUrl':
          'https://play.google.com/store/apps/details?id=com.dentist.dental_store',
      'technologies': ['Flutter', 'Firebase', 'REST APIs'],
    },
    {
      'name': 'Masrat',
      'description':
          'Google Play: Mobile application for streamlined service management.',
      'playStoreUrl':
          'https://play.google.com/store/apps/details?id=com.masrat.app.masrat',
      'technologies': ['Flutter', 'Firebase', 'REST APIs'],
    },
    {
      'name': 'Women\'s Guide',
      'description':
          'Delivered to client (later removed from Google Play): Developed an app providing an informative guide to facilitate women entrepreneurs\' access to legal information.',
      'playStoreUrl': null,
      'technologies': ['Flutter', 'Firebase'],
    },
    {
      'name': 'Additional 6+ unpublished applications',
      'description': 'Mix of private client projects and apps under review.',
      'playStoreUrl': null,
      'technologies': ['Flutter', 'Android', 'Kotlin', 'Java'],
    },
  ];

  // Social Links
  static const Map<String, String> socialLinks = {
    'github': 'https://github.com/HajarSalamah-Developer',
    'email': 'mailto:salamprogramer@gmail.com',
    'phone': 'tel:+967771019495',
  };

  // CV File Name
  static const String cvFileName = 'Hajar_Salamah_CV.pdf';
}
