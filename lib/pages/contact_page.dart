import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive.dart';
import '../widgets/custom_navbar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavbar(),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            left: -100,
            child: _GlowCircle(color: AppColors.primary.withOpacity(0.1)),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _GlowCircle(color: AppColors.secondary.withOpacity(0.1)),
          ),

          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context) ? 100 : 24,
              vertical: 40,
            ),
            child: Column(
              children: [
                FadeInDown(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.secondary.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          'INITIATE CONTACT',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.secondary,
                                letterSpacing: 4,
                              ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Let\'s build the future together.',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: _buildMainContactHub(context),
                  ),
                ),
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

  Widget _buildMainContactHub(BuildContext context) {
    return FadeInUp(
      child: GlassContainer(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Top Section - Visual Accent
            Container(
              height: 4,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Responsive(
                mobile: Column(
                  children: [
                    _buildContactMethod(
                      context,
                      Icons.alternate_email_rounded,
                      'EMAIL ARCHITECTURE',
                      'rakhaarain786@gmail.com',
                      onTap: () => launchUrl(
                        Uri.parse('mailto:rakhaarain786@gmail.com'),
                      ),
                    ),
                    const Divider(height: 60, color: Colors.white10),
                    _buildContactMethod(
                      context,
                      Icons.location_on_outlined,
                      'LOCATION HUB',
                      'Bahawalpur, Pakistan',
                      onTap: null,
                    ),
                    const Divider(height: 60, color: Colors.white10),
                    _buildSocialSection(context),
                  ],
                ),
                desktop: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _buildContactMethod(
                            context,
                            Icons.alternate_email_rounded,
                            'EMAIL ARCHITECTURE',
                            'rakhaarain786@gmail.com',
                            onTap: () => launchUrl(
                              Uri.parse('mailto:rakhaarain786@gmail.com'),
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildContactMethod(
                            context,
                            Icons.location_on_outlined,
                            'LOCATION HUB',
                            'Bahawalpur, Pakistan',
                            onTap: null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      color: Colors.white10,
                    ),
                    Expanded(child: _buildSocialSection(context)),
                  ],
                ),
              ),
            ),
            // Bottom Status Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent,
                      boxShadow: [
                        BoxShadow(color: Colors.greenAccent, blurRadius: 4),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Available for new enterprise-scale projects',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactMethod(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.secondary, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white24,
                size: 14,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialSection(BuildContext context) {
    final socials = [
      {
        'name': 'LinkedIn',
        'icon': Icons.link,
        'url':
            'https://www.linkedin.com/in/allaha-rakha-839779202?utm_source=share_via&utm_content=profile&utm_medium=member_android',
      },
      {
        'name': 'GitHub',
        'icon': Icons.code_rounded,
        'url': 'https://github.com/allaharakha786',
      },
      {
        'name': 'WhatsApp',
        'icon': Icons.chat_bubble_outline_rounded,
        'url':
            'https://wa.me/923081137368?text=Hello%20I%20want%20to%20contact%20you',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SOCIAL ARCHITECTURE',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 24),
        ...socials
            .map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildSocialButton(
                  s['name'] as String,
                  s['icon'] as IconData,
                  s['url'] as String,
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildSocialButton(String name, IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.secondary, size: 18),
            const SizedBox(width: 16),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.open_in_new_rounded,
              color: Colors.white24,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  const _GlowCircle({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 600,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
