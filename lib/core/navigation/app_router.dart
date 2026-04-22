import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laa_mbe/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:laa_mbe/features/google/presentation/screens/drive_screen.dart';
import 'package:laa_mbe/features/google/presentation/screens/calendar_screen.dart';
import 'package:laa_mbe/features/google/presentation/screens/gmail_screen.dart';
import 'package:laa_mbe/features/whatsapp/presentation/screens/whatsapp_screen.dart';
import 'package:laa_mbe/shared/widgets/main_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/drive',
          builder: (context, state) => const DriveScreen(),
        ),
        GoRoute(
          path: '/calendar',
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/gmail',
          builder: (context, state) => const GmailScreen(),
        ),
        GoRoute(
          path: '/whatsapp',
          builder: (context, state) => const WhatsAppScreen(),
        ),
      ],
    ),
  ],
);
