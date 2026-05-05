import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive.dart';
import '../widgets/custom_navbar.dart';
import '../data/projects.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final featured = ProjectData.projects
      .where(
        (p) =>
            p['title'].contains('Trackwise') ||
            p['title'].contains('AO Scan') ||
            p['title'].contains('Handy Bee') ||
            p['title'].contains('MeetParent') ||
            p['title'].contains('Multi-Vender') ||
            p['title'].contains('Street Sweeping'),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < featured.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            left: -100,
            child: _BackgroundGlow(color: AppColors.primary.withOpacity(0.2)),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _BackgroundGlow(
              color: AppColors.secondary.withOpacity(0.15),
            ),
          ),

          // Main Content
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: CustomNavbar()),
              SliverToBoxAdapter(child: _buildHero(context)),
              SliverToBoxAdapter(child: _buildProjectPreview(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
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

  Widget _buildHero(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 100 : 24,
        vertical: isMobile ? 40 : 60,
      ),
      child: Responsive(
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeroText(context, isMobile: true),
            const SizedBox(height: 60),
            _buildHeroImage(isMobile: true),
          ],
        ),
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildHeroText(context, isMobile: false)),
            const SizedBox(width: 40),
            Expanded(child: _buildHeroImage(isMobile: false)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroText(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeInLeft(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Text(
              'AVAILABLE FOR NEW PROJECTS',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontSize: 10),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FadeInLeft(
          delay: const Duration(milliseconds: 200),
          child: Text(
            'Crafting High-Performance\nMobile Apps',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: isMobile ? 42 : 72,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 24),
        FadeInLeft(
          delay: const Duration(milliseconds: 400),
          child: Container(
            constraints: BoxConstraints(maxWidth: isMobile ? 400 : 550),
            child: Text(
              'I craft premium mobile experiences with architectural precision and futuristic aesthetics.',
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                fontSize: isMobile ? 14 : 18,
                height: 1.6,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: Row(
            mainAxisAlignment:
                isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              _buildPrimaryButton(context, 'View My Work'),
              const SizedBox(width: 20),
              _buildSecondaryButton('CV'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage({required bool isMobile}) {
    return FadeInRight(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: isMobile ? 250 : 450,
              height: isMobile ? 250 : 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Image.asset(
              'hero-image.png',
              height: isMobile ? 320 : 550,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.phone_android,
                size: 100,
                color: Colors.white10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, String title) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/portfolio'),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String title) {
    return SizedBox(
      height: 56,
      child: OutlinedButton(
        onPressed: () async {
          // For web builds, assets are typically at assets/assets/...
          String path = 'assets/Allaha_Rakha_cv.pdf';
          if (kIsWeb) {
            path = 'assets/assets/Allaha_Rakha_cv.pdf';
          }
          final Uri url = Uri.parse(path);
          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            // If the specific web path fails, try the standard one as fallback
            if (kIsWeb) {
              await launchUrl(Uri.parse('assets/Allaha_Rakha_cv.pdf'),
                  mode: LaunchMode.externalApplication);
            }
          }
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          side: BorderSide(color: AppColors.textSecondary.withOpacity(0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectPreview(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 100 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Text(
            'FEATURED PROJECTS',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(letterSpacing: 2),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 120, // Height of the card
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: featured.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.hasContentDimensions) {
                      value = (_pageController.page! - index).abs();
                      value = (1 - (value * 0.3)).clamp(0.0, 1.0);
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeOut.transform(value) * 120,
                        width: double.infinity,
                        child: child,
                      ),
                    );
                  },
                  child: _buildProjectCard(context, featured[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Page Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              featured.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.secondary
                      : AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, '/project-detail', arguments: project),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                project['image'],
                height: 70,
                width: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 70,
                  width: 70,
                  color: Colors.white.withOpacity(0.05),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.white10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    project['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (project['tech'] as List<String>).join(' • '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white24,
              size: 16,
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
      width: 600,
      height: 600,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
