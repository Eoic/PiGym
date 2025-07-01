import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const iconsRoot = 'assets/icons/menu';

class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final String icon;

  const MenuButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...[
              SvgPicture.asset(
                '$iconsRoot/$icon.svg',
                fit: BoxFit.contain,
                height: 60,
                width: 60,
                semanticsLabel: title,
              ),
              SizedBox(width: 14),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontFamily: 'MadimiOne',
                  fontSize: 52,
                ),
              ),
              const SizedBox(width: 10),
            ],
            // Text(title, style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
