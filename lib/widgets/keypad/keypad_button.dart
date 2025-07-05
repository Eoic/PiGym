import 'package:flutter/material.dart';

class KeypadButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const KeypadButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3A4148),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          fontFamily: 'MadimiOne',
        ),
      ),
    );
  }
}
