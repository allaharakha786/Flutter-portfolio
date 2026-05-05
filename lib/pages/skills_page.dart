import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive.dart';
import '../widgets/custom_navbar.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavbar(),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 100 : 24,
          vertical: 40,
        ),
        child: Column(
          children: [
            FadeInDown(
              child: Column(
                children: [
                  Text(
                    'EXPERTISE',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Technical Arsenal',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            _buildSkillsGrid(context),
            const SizedBox(height: 100),
          ],
        ),
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

  Widget _buildSkillsGrid(BuildContext context) {
    final skillGroups = [
      {
        'title': 'Frontend Excellence',
        'skills': [
          {'name': 'Flutter', 'icon': Icons.flutter_dash},
          {'name': 'Dart', 'icon': Icons.code},
          {'name': 'Material Design', 'icon': Icons.design_services},
          {'name': 'Responsive UI', 'icon': Icons.aspect_ratio},
        ],
      },
      {
        'title': 'Backend & Cloud',
        'skills': [
          {'name': 'Firebase', 'icon': Icons.cloud},
          {'name': 'REST APIs', 'icon': Icons.api},
          {'name': 'Mailchimp', 'icon': Icons.mail},
          {'name': 'EmailJS', 'icon': Icons.email},
        ],
      },
      {
        'title': 'State Management',
        'skills': [
          {'name': 'GetX', 'icon': Icons.bolt},
          {'name': 'BLoC', 'icon': Icons.architecture},
          {'name': 'Provider', 'icon': Icons.layers},
          {'name': 'GetIt', 'icon': Icons.settings_input_component},
        ],
      },
      {
        'title': 'Tools & Devops',
        'skills': [
          {'name': 'Git & GitHub', 'icon': Icons.terminal},
          {'name': 'CI/CD', 'icon': Icons.speed},
          {'name': 'Figma', 'icon': Icons.brush},
          {'name': 'Play Store', 'icon': Icons.shop},
        ],
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skillGroups.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        mainAxisExtent: 250,
      ),
      itemBuilder: (context, index) {
        final group = skillGroups[index];
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: GlassContainer(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group['title'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: (group['skills'] as List<Map<String, dynamic>>)
                        .map(
                          (s) => _buildSkillBadge(
                            s['name'] as String,
                            s['icon'] as IconData,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillBadge(String name, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white70),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
