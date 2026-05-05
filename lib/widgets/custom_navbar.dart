import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';
import '../widgets/responsive.dart';
import '../widgets/glass_container.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return AppBar(
      automaticallyImplyLeading: false, // Remove back arrow
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: FadeInDown(
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/'),
              child: Row(
                children: [
                  const Text(
                    'ALLAH ',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'RAKHA',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (!Responsive.isMobile(context)) ...[
              _buildNavButton(context, 'About', '/about', currentRoute == '/about'),
              _buildNavButton(context, 'Projects', '/portfolio', currentRoute == '/portfolio'),
              _buildNavButton(context, 'Experience', '/experience', currentRoute == '/experience'),
              const SizedBox(width: 20),
              _buildContactNavButton(context, currentRoute == '/contact'),
            ],
            if (Responsive.isMobile(context))
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, String route, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () {
          if (!isActive) Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? AppColors.secondary : AppColors.textSecondary,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 20,
                color: AppColors.secondary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactNavButton(BuildContext context, bool isActive) {
    return InkWell(
      onTap: () {
        if (!isActive) Navigator.pushNamed(context, '/contact');
      },
      child: GlassContainer(
        borderRadius: 30,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        opacity: isActive ? 0.3 : 0.1,
        child: Text(
          'Hire Me',
          style: TextStyle(
            color: isActive ? AppColors.secondary : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
