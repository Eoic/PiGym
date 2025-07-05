import 'package:flutter/material.dart';
import 'package:pigym/widgets/keypad/keypad.dart';
import 'package:pigym/widgets/digits_belt.dart';

class CodeEntryScreen extends StatefulWidget {
  const CodeEntryScreen({super.key});

  @override
  State<CodeEntryScreen> createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {
  late void Function(String) _handleKeyPressed;

  void _onKeyPressed(String digit) {
    _handleKeyPressed.call(digit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: From constructor, either practice or challenge.
        title: const Text('Practice'),
        backgroundColor: const Color(0xFF2D3238),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          DigitsBelt(
            builder:
                (BuildContext context, void Function(String) handleKeyPressed) =>
                    _handleKeyPressed = handleKeyPressed,
          ),
          const Spacer(),
          Keypad(onKeyPressed: _onKeyPressed),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
