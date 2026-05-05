import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive.dart';
import '../widgets/custom_navbar.dart';

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({super.key});

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
                    'TESTIMONIALS',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Trusted by Global Clients',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            _buildTestimonialsGrid(context),
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

  Widget _buildTestimonialsGrid(BuildContext context) {
    final testimonials = [
      {
        'name': 'Alex Johnson',
        'role': 'Product Manager',
        'content':
            'Working with this developer was a game-changer for our project. The attention to detail and architectural precision in Flutter is unmatched.',
      },
      {
        'name': 'Sarah Williams',
        'role': 'Startup Founder',
        'content':
            'Highly professional and fast delivery. The app performance and smooth animations exceeded our expectations.',
      },
      {
        'name': 'Michael Chen',
        'role': 'Tech Lead',
        'content':
            'Clean code and scalable architecture. A true professional who understands both design and backend integration perfectly.',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: testimonials.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isDesktop(context) ? 3 : 1,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        mainAxisExtent: 280,
      ),
      itemBuilder: (context, index) {
        final t = testimonials[index];
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: GlassContainer(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.format_quote,
                  color: AppColors.secondary,
                  size: 40,
                ),
                const SizedBox(height: 16),
                Text(
                  t['content']!,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.6,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Spacer(),
                Text(
                  t['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  t['role']!,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
