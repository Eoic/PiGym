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
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...[
                SvgPicture.asset(
                  '$iconsRoot/$icon.svg',
                  fit: BoxFit.contain,
                  height: 60,
                  width: 60,
                  semanticsLabel: title,
                ),
                SizedBox(width: 24.0),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
