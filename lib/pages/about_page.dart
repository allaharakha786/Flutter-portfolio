import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive.dart';
import '../widgets/custom_navbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomNavbar(),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 100 : 24,
          vertical: 60,
        ),
        child: Column(
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 100),
            _buildDetailedBio(context),
            const SizedBox(height: 100),
            _buildSocialArchitecture(context),
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

  Widget _buildHeroSection(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Responsive(
      mobile: Column(
        children: [
          _buildProfileFrame(isMobile: true),
          const SizedBox(height: 60),
          _buildHeroText(context, isMobile: true),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildProfileFrame(isMobile: false)),
          const SizedBox(width: 80),
          Expanded(flex: 2, child: _buildHeroText(context, isMobile: false)),
        ],
      ),
    );
  }

  Widget _buildProfileFrame({required bool isMobile}) {
    return FadeInLeft(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Glow
            Container(
              width: isMobile ? 260 : 360,
              height: isMobile ? 300 : 420,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            // Glass Border
            Container(
              width: isMobile ? 250 : 350,
              height: isMobile ? 290 : 410,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.01)],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  'assets/images/profile.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.white10,
                    child: const Icon(Icons.person, color: Colors.white10, size: 80),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroText(BuildContext context, {required bool isMobile}) {
    return FadeInRight(
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'THE ARCHITECT',
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 4,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Architecting Digital\nExcellence.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: isMobile ? 36 : 56,
              height: 1.1,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 32),
          _buildQuickStats(isMobile),
        ],
      ),
    );
  }

  Widget _buildQuickStats(bool isMobile) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        _buildStatChip('3+ YEARS', Icons.bolt_rounded),
        _buildStatChip('20+ PROJECTS', Icons.rocket_launch_rounded),
        _buildStatChip('100% SUCCESS', Icons.verified_user_rounded),
      ],
    );
  }

  Widget _buildStatChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.secondary, size: 14),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedBio(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Responsive.isDesktop(context))
          Expanded(
            child: FadeInLeft(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PHILOSOPHY',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildPhilosophyItem('Precision', 'Pixel-perfect UI across all platforms.'),
                  _buildPhilosophyItem('Scalability', 'Modular architecture for global impact.'),
                  _buildPhilosophyItem('Performance', 'Optimized logic for smooth user journeys.'),
                ],
              ),
            ),
          ),
        if (Responsive.isDesktop(context)) const SizedBox(width: 80),
        Expanded(
          flex: 2,
          child: FadeInRight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WHO I AM',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'I am a passionate Flutter Developer with over 3 years of experience in crafting high-performance, cross-platform mobile applications. My expertise lies in architecting scalable solutions that blend technical precision with breathtaking design.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.8,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Throughout my career, I have collaborated with diverse teams to deliver production-ready apps that solve real-world problems. I believe in clean code, reactive state management, and the power of a pixel-perfect user interface.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.8,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhilosophyItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialArchitecture(BuildContext context) {
    return Column(
      children: [
        const Text(
          'CONNECTING WORLDWIDE',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _buildSocialArchitectButton(
              'LINKEDIN',
              'https://www.linkedin.com/in/allaha-rakha-839779202?utm_source=share_via&utm_content=profile&utm_medium=member_android',
            ),
            _buildSocialArchitectButton('GITHUB', 'https://github.com/allaharakha786'),
            _buildSocialArchitectButton(
              'WHATSAPP',
              'https://wa.me/923081137368?text=Hello%20I%20want%20to%20contact%20you',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialArchitectButton(String label, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        borderRadius: 12,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 12),
        ),
      ),
    );
  }
}
