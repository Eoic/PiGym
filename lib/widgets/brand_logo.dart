import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final brandIcon = isDarkMode ? 'assets/icons/brand/brand-dark.svg' : 'assets/icons/brand/brand-light.svg';

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          brandIcon,
          fit: BoxFit.contain,
          height: 64,
          width: 64,
          semanticsLabel: 'PiGym logo',
        ),
        SizedBox(width: 12),
        Text(
          'PiGym',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontFamily: 'MadimiOne',
            fontSize: 52,
          ),
        ),
      ],
    );
  }
}