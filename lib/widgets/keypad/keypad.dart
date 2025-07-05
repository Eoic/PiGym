import 'package:flutter/material.dart';
import 'package:pigym/widgets/keypad/keypad_button.dart';

class Keypad extends StatelessWidget {
  final ValueChanged<int> onKeyPressed;

  const Keypad({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              int digit = index + 1;

              return KeypadButton(
                text: digit.toString(),
                onPressed: () => onKeyPressed(digit),
              );
            },
          ),
          KeypadButton(text: '0', onPressed: () => onKeyPressed(0)),
        ],
      ),
    );
  }
}
