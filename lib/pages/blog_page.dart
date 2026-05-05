import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 100 : 24,
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DECODING THE FUTURE', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 16),
                  Text('Insights into the next generation of mobile tech.',
                      style: Theme.of(context).textTheme.displayMedium),
                ],
              ),
            ),
            const SizedBox(height: 80),
            _buildFeaturedArticle(context),
            const SizedBox(height: 60),
            _buildArticlesGrid(context),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedArticle(BuildContext context) {
    return FadeInUp(
      child: GlassContainer(
        padding: EdgeInsets.zero,
        child: Responsive(
          mobile: _buildFeaturedContent(context, isMobile: true),
          desktop: _buildFeaturedContent(context, isMobile: false),
        ),
      ),
    );
  }

  Widget _buildFeaturedContent(BuildContext context, {required bool isMobile}) {
    final content = Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: const Text('FEATURED', style: TextStyle(color: AppColors.secondary, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              const Text('12 MIN READ', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 24),
          const Text('The Evolution of Cross-Platform Performance', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          const Text('Deep diving into the rendering engines of modern frameworks and how they compare in high-stakes enterprise environments.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.6)),
          const SizedBox(height: 40),
          _buildReadMoreButton(),
        ],
      ),
    );

    if (isMobile) return content;

    return Row(
      children: [
        Expanded(flex: 2, child: content),
        Expanded(
          child: Container(
            height: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('hero-image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArticlesGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        mainAxisExtent: 300,
      ),
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildArticleCard(context),
        );
      },
    );
  }

  Widget _buildArticleCard(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ARCHITECTURE', style: TextStyle(color: AppColors.secondary, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Designing Scalable API Gateways', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text('Best practices for managing high-traffic mobile backends with Node.js and GraphQL.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('MAY 24, 2024', style: TextStyle(color: Colors.white38, fontSize: 10)),
              _buildReadMoreButton(small: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReadMoreButton({bool small = false}) {
    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Read More', style: TextStyle(color: AppColors.secondary, fontSize: small ? 12 : 16)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, color: AppColors.secondary, size: 16),
        ],
      ),
    );
  }
}
