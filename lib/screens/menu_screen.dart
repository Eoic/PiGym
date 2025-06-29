import 'package:flutter/material.dart';
import 'package:pigym/widgets/brand_logo.dart';
import 'package:pigym/widgets/menu_button.dart';
import 'package:go_router/go_router.dart';

class MenuButtonSpec {
  final String title;
  final VoidCallback onPressed;
  final IconData icon;

  MenuButtonSpec({
    required this.title,
    required this.icon,
    required this.onPressed,
  });
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static final List<MenuButtonSpec> _menuItems = [
    MenuButtonSpec(
      title: 'Practice',
      icon: Icons.play_circle_filled,
      onPressed: () {},
    ),
    MenuButtonSpec(title: 'Challenges', icon: Icons.sports, onPressed: () {}),
    MenuButtonSpec(title: 'Scores', icon: Icons.score, onPressed: () {}),
    MenuButtonSpec(
      title: 'Statistics',
      icon: Icons.bar_chart,
      onPressed: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BrandLogo(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          _menuItems
                              .expand(
                                (item) => [
                                  MenuButton(
                                    icon: item.icon,
                                    title: item.title,
                                    onPressed: item.onPressed,
                                  ),
                                  if (_menuItems.last != item)
                                    const SizedBox(height: 32),
                                ],
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  context.go('/settings');
                },
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: const Icon(Icons.settings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
