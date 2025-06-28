import "package:flutter/material.dart";
import "package:pigym/widgets/brand-logo.dart";
import "package:pigym/widgets/menu-button.dart";

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BrandLogo(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuButton(title: "Practice", onPressed: () {}, icon: Icons.play_circle_filled,),
                        const SizedBox(height: 24,),
                        MenuButton(title: "Challenges", onPressed: () {}, icon: Icons.sports,),
                        const SizedBox(height: 24,),
                        MenuButton(title: "Statistics", onPressed: () {}, icon: Icons.bar_chart,),
                      ],
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
                  // context.go("/settings");
                },
                child: const Icon(Icons.settings),
                ),
              )
          ],
        )
      ),
    );
  }
}
