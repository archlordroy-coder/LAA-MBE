import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/main_shell.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/google_drive/presentation/pages/google_drive_page.dart';
import '../../features/google_calendar/presentation/pages/google_calendar_page.dart';
import '../../features/gmail/presentation/pages/gmail_page.dart';
import '../../features/whatsapp/presentation/pages/whatsapp_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/drive',
              builder: (context, state) => const GoogleDrivePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendar',
              builder: (context, state) => const GoogleCalendarPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/gmail',
              builder: (context, state) => const GmailPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/whatsapp',
              builder: (context, state) => const WhatsAppPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
