import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? icon;

  const MenuButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 50, vertical: 36),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 38),
              const SizedBox(width: 10),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
