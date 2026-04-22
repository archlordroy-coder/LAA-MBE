import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../features/ai_companion/presentation/widgets/ai_companion_sidebar.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar (Navigation Rail) - Fixed width 72px
          SizedBox(
            width: 72,
            child: AppNavigationRail(navigationShell: navigationShell),
          ),

          // Central Area (Main Content) - Flexible width
          Expanded(
            child: Container(
              color: AppColors.background,
              child: navigationShell,
            ),
          ),

          // Right Sidebar (AI Companion) - Fixed width 340px
          const SizedBox(
            width: 340,
            child: AICompanionSidebar(),
          ),
        ],
      ),
    );
  }
}

// Temporary placeholder for NavigationRail
class AppNavigationRail extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppNavigationRail({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sidebarBackground,
      child: Column(
        children: [
          const SizedBox(height: 24),
          const FlutterLogo(size: 32),
          const SizedBox(height: 32),
          _buildNavItem(context, 0, Icons.dashboard_outlined, Icons.dashboard),
          _buildNavItem(context, 1, Icons.folder_outlined, Icons.folder),
          _buildNavItem(context, 2, Icons.calendar_today_outlined, Icons.calendar_today),
          _buildNavItem(context, 3, Icons.email_outlined, Icons.email),
          _buildNavItem(context, 4, Icons.chat_outlined, Icons.chat),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, IconData selectedIcon) {
    final isSelected = navigationShell.currentIndex == index;
    return IconButton(
      icon: Icon(
        isSelected ? selectedIcon : icon,
        color: isSelected ? AppColors.accent : AppColors.textSecondary,
      ),
      onPressed: () => navigationShell.goBranch(index),
    );
  }
}
