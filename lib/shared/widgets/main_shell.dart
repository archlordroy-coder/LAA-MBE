import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laa_mbe/features/ai/presentation/widgets/ai_pane.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laa_mbe/core/theme/app_theme.dart';

class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/drive');
        break;
      case 2:
        context.go('/calendar');
        break;
      case 3:
        context.go('/gmail');
        break;
      case 4:
        context.go('/whatsapp');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            minWidth: 72,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => _onItemTapped(index, context),
            labelType: NavigationRailLabelType.none,
            useIndicator: true,
            indicatorColor: Colors.white24,
            backgroundColor: AppTheme.indigoNdop,
            unselectedIconTheme: const IconThemeData(color: Colors.white70),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.googleDrive),
                label: Text('Drive'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: Text('Calendar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.email_outlined),
                selectedIcon: Icon(Icons.email),
                label: Text('Gmail'),
              ),
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.whatsapp),
                label: Text('WhatsApp'),
              ),
            ],
          ),
          Expanded(
            child: widget.child,
          ),
          const AIPane(),
        ],
      ),
    );
  }
}
