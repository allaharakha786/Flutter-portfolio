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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomNavbar(),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMinimalHeader(context),
            _buildMainContentSplit(context),
            if (project['showcase'] != null) _buildInteractiveGallery(context),
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

  Widget _buildMinimalHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 100 : 24,
        vertical: 40,
      ),
      child: FadeInDown(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                project['category'] ?? 'MOBILE APP',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              project['title'] ?? 'Project Title',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: Responsive.isDesktop(context) ? 56 : 36,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 2,
              width: 80,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContentSplit(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 100 : 24,
      ),
      child: Responsive(
        mobile: Column(
          children: [
            _buildProjectImageMockup(context, isMobile: true),
            const SizedBox(height: 40),
            _buildProjectInfoPanel(context),
          ],
        ),
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _buildProjectInfoPanel(context)),
            const SizedBox(width: 80),
            Expanded(
              flex: 2,
              child: _buildProjectImageMockup(context, isMobile: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectInfoPanel(BuildContext context) {
    return FadeInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'THE MISSION',
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            project['fullDesc'] ?? project['desc'] ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.8,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 48),
          _buildTechGrid(context),
          if (project['playStore'] != null) ...[
            const SizedBox(height: 48),
            _buildStoreLink(context, project['playStore']),
          ],
        ],
      ),
    );
  }

  Widget _buildTechGrid(BuildContext context) {
    final tech = (project['tech'] as List<String>?) ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TECHNOLOGY STACK',
          style: TextStyle(
            color: AppColors.textSecondary.withOpacity(0.5),
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: tech.map((t) => _buildModernTag(t)).toList(),
        ),
      ],
    );
  }

  Widget _buildModernTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 13),
      ),
    );
  }

  Widget _buildProjectImageMockup(
    BuildContext context, {
    required bool isMobile,
  }) {
    return FadeInRight(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(
              project['image'] ?? 'hero-image.png',
              width: isMobile ? 250 : 350,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 250,
                height: 500,
                color: Colors.white10,
                child: const Icon(
                  Icons.phone_android,
                  color: Colors.white10,
                  size: 60,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoreLink(BuildContext context, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/google_play_store_icon.png',
              height: 24,
              width: 24,
              errorBuilder: (context, error, stackTrace) => 
                const Icon(Icons.shop_2_rounded, color: Colors.white),
            ),
            const SizedBox(width: 16),
            const Text(
              'EXPLORE ON PLAY STORE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 13,
              ),
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
          child: Text(
            'INTERFACE ARCHITECTURE',
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 550,
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
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: FadeInRight(
                    delay: Duration(milliseconds: index * 100),
                    child: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
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
