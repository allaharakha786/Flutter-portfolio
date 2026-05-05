import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive.dart';
import '../widgets/custom_navbar.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomNavbar(),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // Ambient Atmosphere
          Positioned(
            top: 200,
            left: -150,
            child: _BackgroundGlow(color: AppColors.primary.withOpacity(0.1)),
          ),
          Positioned(
            bottom: 100,
            right: -100,
            child: _BackgroundGlow(color: AppColors.secondary.withOpacity(0.1)),
          ),

          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context) ? 100 : 24,
              vertical: 60,
            ),
            child: Column(
              children: [
                FadeInDown(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'PROFESSIONAL JOURNEY',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Career Architecture',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                _buildExperienceTimeline(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'ALLAHA RAKHA',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _buildDrawerItem(context, 'About', '/about'),
          _buildDrawerItem(context, 'Projects', '/portfolio'),
          _buildDrawerItem(context, 'Experience', '/experience'),
          _buildDrawerItem(context, 'Contact', '/contact'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    final experiences = [
      {
        'role': 'Flutter Developer',
        'company': 'SynticAI | Bahawalpur, Pakistan',
        'period': 'Nov 2024 – April 2026',
        'details': [
          'Developed and maintained high-performance cross-platform mobile applications using Flutter and Dart for Android and iOS platforms.',
          'Designed and implemented scalable, reusable widget components following Material Design guidelines and responsive UI best practices.',
          'Integrated RESTful APIs using Dio and HTTP packages, handling JSON parsing, authentication tokens, and error states.',
          'Implemented BLoC and GetX state management patterns to ensure clean architecture and separation of business logic.',
          'Integrated Firebase services including Authentication, Cloud Firestore, and Push Notifications for real-time app functionality.',
          'Optimized app performance by reducing build times, identifying memory leaks, and improving widget rendering efficiency.',
          'Collaborated with UI/UX designers and backend engineers in an Agile environment to deliver features on schedule.'
        ],
      },
      {
        'role': 'Junior Flutter Developer',
        'company': 'Createex | Lahore, Pakistan',
        'period': 'Feb 2024 – Oct 2024',
        'details': [
          'Contributed to the development of cross-platform mobile applications using Flutter for clients across multiple industries.',
          'Built responsive UI components and screens from Figma designs, ensuring pixel-accurate implementation on both Android and iOS.',
          'Integrated REST APIs, handled JSON serialization/deserialization, and managed API error handling and loading states.',
          'Fixed software bugs, improved code quality, and conducted code reviews with senior developers to uphold best practices.',
          'Collaborated with senior developers and product teams to implement user-facing features within sprint deadlines.'
        ],
      },
      {
        'role': 'Flutter Developer',
        'company': 'TechSwivel | Lahore, Pakistan',
        'period': 'Aug 2023 – Jan 2024',
        'details': [
          'Gained practical, hands-on experience in cross-platform mobile application development using Flutter and Dart.',
          'Assisted in building user interface screens, integrating third-party APIs, and implementing core application features.',
          'Participated in debugging sessions, code quality improvements, and technical discussions with senior developers.',
          'Followed Agile development processes, attended daily standups, and contributed to sprint planning and retrospectives.'
        ],
      },
      {
        'role': 'Flutter Developer Intern',
        'company': 'Enigmatix | Bahawalpur, Pakistan',
        'period': 'Feb 2023 – July 2023',
        'details': [
          'Developed foundational skills in Flutter and Dart by contributing to real-world cross-platform mobile application projects.',
          'Assisted in building and testing UI screens, integrating APIs, and implementing app features under senior developer supervision.',
          'Participated in code reviews, debugging sessions, and team meetings to learn industry-standard development workflows.',
          'Gained hands-on exposure to Git version control, Agile methodology, and mobile app deployment processes.'
        ],
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        return _ExperienceCard(
          experience: experiences[index],
          isFirst: index == 0,
          isLast: index == experiences.length - 1,
          index: index,
        );
      },
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Map<String, dynamic> experience;
  final bool isFirst;
  final bool isLast;
  final int index;

  const _ExperienceCard({
    required this.experience,
    required this.isFirst,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    
    return FadeInUp(
      delay: Duration(milliseconds: index * 100),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline Rail
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: isFirst ? AppColors.secondary : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondary,
                        width: 2,
                      ),
                      boxShadow: isFirst ? [
                        BoxShadow(
                          color: AppColors.secondary.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ] : null,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.secondary.withOpacity(0.5),
                              AppColors.secondary.withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: GlassContainer(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  experience['role'] as String,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  experience['company'] as String,
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isDesktop)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                experience['period'] as String,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (!isDesktop) ...[
                        const SizedBox(height: 12),
                        Text(
                          experience['period'] as String,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      ...(experience['details'] as List<String>).map((d) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Icon(Icons.circle, size: 4, color: AppColors.secondary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                d,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  final Color color;
  const _BackgroundGlow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
