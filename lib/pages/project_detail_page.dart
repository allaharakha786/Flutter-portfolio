import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive.dart';
import '../widgets/custom_navbar.dart';

class ProjectDetailPage extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomNavbar(),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // Background Decorative Elements
          Positioned(
            top: 100,
            right: -100,
            child: _BackgroundGlow(color: AppColors.primary.withOpacity(0.1)),
          ),
          Positioned(
            bottom: 200,
            left: -100,
            child: _BackgroundGlow(color: AppColors.secondary.withOpacity(0.1)),
          ),

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildModernHero(context, isMobile),
                const SizedBox(height: 60),
                _buildMainContentSection(context, isMobile),
                if (project['showcase'] != null) ...[
                  const SizedBox(height: 80),
                  _buildInteractiveGallery(context),
                ],
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

  Widget _buildModernHero(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 100 : 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    project['category'] ?? 'MOBILE APP',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          FadeInLeft(
            duration: const Duration(milliseconds: 800),
            child: Text(
              project['title'] ?? 'Project Title',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 42 : 82,
                height: 1.1,
                fontWeight: FontWeight.w900,
                letterSpacing: -2,
              ),
            ),
          ),
          const SizedBox(height: 32),
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: Container(
              height: 4,
              width: 120,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContentSection(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 100 : 24,
      ),
      child: Responsive(
        mobile: Column(
          children: [
            _buildFeaturedMockup(context, isMobile: true),
            const SizedBox(height: 60),
            _buildDetailedInfoPanel(context),
          ],
        ),
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _buildDetailedInfoPanel(context)),
            const SizedBox(width: 80),
            Expanded(
              flex: 2,
              child: _buildFeaturedMockup(context, isMobile: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedInfoPanel(BuildContext context) {
    final String fullDesc = project['fullDesc'] ?? project['desc'] ?? '';
    final List<String> paragraphs = fullDesc.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInLeft(
          delay: const Duration(milliseconds: 200),
          child: _buildSectionLabel('OVERVIEW'),
        ),
        const SizedBox(height: 24),
        for (var p in paragraphs) ...[
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: Text(
              p,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.8,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
        const SizedBox(height: 48),
        FadeInLeft(
          delay: const Duration(milliseconds: 400),
          child: _buildSectionLabel('TECHNOLOGIES'),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          delay: const Duration(milliseconds: 500),
          child: _buildTechStack(context),
        ),
        if (project['playStore'] != null) ...[
          const SizedBox(height: 56),
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            child: _buildPlayStoreButton(context, project['playStore']),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Row(
      children: [
        Container(width: 24, height: 2, color: AppColors.secondary),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildTechStack(BuildContext context) {
    final tech = (project['tech'] as List<String>?) ?? [];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: tech.map((t) => _buildGlassTag(t)).toList(),
    );
  }

  Widget _buildGlassTag(String text) {
    return GlassContainer(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      borderRadius: 12,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFeaturedMockup(BuildContext context, {required bool isMobile}) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Floating Glow Effect
            Container(
              width: isMobile ? 220 : 320,
              height: isMobile ? 400 : 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Mockup Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  project['image'] ?? 'hero-image.png',
                  width: isMobile ? 280 : 380,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 280,
                    height: 550,
                    color: Colors.white.withOpacity(0.05),
                    child: const Icon(
                      Icons.phone_android,
                      color: Colors.white10,
                      size: 80,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayStoreButton(BuildContext context, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/google_play_store_icon.png',
              height: 28,
              width: 28,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.shop_2_rounded, color: Colors.white),
            ),
            const SizedBox(width: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GET IT ON',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                Text(
                  'Google Play',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveGallery(BuildContext context) {
    final List<String> showcase = List<String>.from(project['showcase'] ?? []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 100 : 24,
          ),
          child: _buildSectionLabel('INTERFACE SHOWCASE'),
        ),
        const SizedBox(height: 48),
        SizedBox(
          height: 600,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context) ? 100 : 24,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: showcase.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: FadeInUp(
                    delay: Duration(milliseconds: index * 150),
                    child: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          showcase[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white10,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
