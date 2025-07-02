import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pigym/dto/challenge_config.dart';
import 'package:pigym/screens/challenge_form_screen.dart';
import 'package:pigym/screens/challenge_screen.dart';
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
        GoRoute(
          path: 'challenge-form',
          builder: (BuildContext context, GoRouterState state) {
            return const ChallengeFormScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'challenge',
              builder: (BuildContext context, GoRouterState state) {
                final config = state.extra as ChallengeConfig?;

                if (config == null) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Error: missing challenge config.'),
                    ),
                  );
                }

                return ChallengeScreen(config: config,);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
