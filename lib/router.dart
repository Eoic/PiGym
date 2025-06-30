import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pigym/screens/menu_screen.dart';
import 'package:pigym/screens/practice_screen.dart';
import 'package:pigym/screens/settings_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MenuScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
        GoRoute(
          path: 'practice',
          builder: (BuildContext context, GoRouterState state) {
            return const PracticeScreen();
          },
        ),
      ],
    ),
  ],
);
