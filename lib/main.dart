import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/skills_page.dart';
import 'pages/portfolio_page.dart';
import 'pages/experience_page.dart';
import 'pages/contact_page.dart';
import 'pages/testimonials_page.dart';
import 'pages/blog_page.dart';
import 'pages/project_detail_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALLAHA RAKHA | Premium Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const HomePage(),
            );
          case '/about':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const AboutPage(),
            );
          case '/skills':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const SkillsPage(),
            );
          case '/portfolio':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const PortfolioPage(),
            );
          case '/experience':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const ExperiencePage(),
            );
          case '/contact':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const ContactPage(),
            );
          case '/testimonials':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const TestimonialsPage(),
            );
          case '/blog':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const BlogPage(),
            );
          case '/project-detail':
            final project = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => ProjectDetailPage(project: project),
            );
          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const HomePage(),
            );
        }
      },
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            Positioned(bottom: 24, right: 24, child: _GlobalWhatsAppButton()),
          ],
        );
      },
    );
  }
}

class _GlobalWhatsAppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => launchUrl(
          Uri.parse(
            'https://wa.me/923081137368?text=Hello%20I%20want%20to%20contact%20you',
          ),
        ),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Image.asset(
              'assets/images/whatsapp_.webp',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.chat, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
