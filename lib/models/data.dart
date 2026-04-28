import 'dart:ui';

class Experience {
  final String company;
  final String role;
  final String period;
  final List<String> highlights;
  final Color color;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.highlights,
    required this.color,
  });
}

class Project {
  final String name;
  final String description;
  final String icon;

  const Project({
    required this.name,
    required this.description,
    required this.icon,
  });
}

class SkillCategory {
  final String category;
  final List<String> skills;

  const SkillCategory({required this.category, required this.skills});
}


final List<Experience> experiences = [
  Experience(
    company: 'MindMade Technologies',
    role: 'Flutter Developer',
    period: 'April 2024 – Present',
    highlights: [
      'Reduced app load time by 35% via lazy loading & widget tree optimization',
      'Implemented BLoC & Provider patterns, cutting crash rates by 40%',
      'Led integration of RESTful APIs and Firebase real-time services',
      'Mentored junior devs on best practices, code reviews & Git workflows',
    ],
    color: Color(0xFF00E5CC),
  ),
  Experience(
    company: 'Primated Development Solution Pvt Ltd',
    role: 'Flutter Developer',
    period: 'Nov 2022 – Mar 2024',
    highlights: [
      'Integrated RESTful APIs & Firebase for seamless cross-platform sync',
      'Collaborated with PMs & designers to translate requirements into specs',
      'Implemented Hive & SQLite for offline-first app functionality',
      'Designed & built UI/UX for 4 customer-facing Flutter applications',
    ],
    color: Color(0xFFFF6B35),
  ),
  Experience(
    company: 'Techeva IT Solution Private Limited',
    role: 'Trainee iOS Developer',
    period: 'May 2022 – Nov 2022',
    highlights: [
      'Developed native iOS features using Swift for enhanced UX',
      'Published iOS apps to the App Store following Apple guidelines',
      'Assisted in cross-platform testing & QA across multiple device sizes',
    ],
    color: Color(0xFFB388FF),
  ),
];

final List<Project> projects = [
  Project(
    name: 'Nokia Voice Assistance',
    description: 'AI-powered voice assistant app for Nokia devices',
    icon: '🎙️',
  ),
  Project(
    name: 'Veromatic Coffee Machine',
    description: 'IoT control app for smart coffee machines',
    icon: '☕',
  ),
  Project(
    name: 'Cakey',
    description: 'On-demand cake ordering & delivery platform',
    icon: '🎂',
  ),
  Project(
    name: 'Fortune Automation',
    description: 'Live tracking management system',
    icon: '⚙️',
  ),
  Project(
    name: 'Dhaalpay',
    description: 'Seamless digital payments solution',
    icon: '💳',
  ),
  Project(
    name: 'The Fish House',
    description: 'Seafood restaurant ordering & management app',
    icon: '🐟',
  ),
];

final List<SkillCategory> skillCategories = [
  SkillCategory(
    category: 'Mobile',
    skills: ['Flutter', 'Dart', 'iOS', 'Swift'],
  ),
  SkillCategory(
    category: 'State Management',
    skills: ['BLoC', 'Provider'],
  ),
  SkillCategory(
    category: 'Backend & APIs',
    skills: ['RESTful APIs', 'Firebase', 'API Integration'],
  ),
  SkillCategory(
    category: 'Storage',
    skills: ['SQLite', 'Hive', 'Local Storage'],
  ),
  SkillCategory(
    category: 'Tools',
    skills: ['GitHub', 'Postman', 'Android Studio', 'VS Code', 'Xcode'],
  ),
  SkillCategory(
    category: 'Deployment',
    skills: ['Google Play Store', 'Apple App Store'],
  ),
  SkillCategory(
    category: 'Soft Skills',
    skills: ['Scrum', 'Mentoring', 'Team Collaboration', 'Problem Solving'],
  ),
];
