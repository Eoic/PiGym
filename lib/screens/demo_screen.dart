import 'package:flutter/material.dart';
import 'package:pigym/widgets/keypad/keypad.dart';
import 'package:pigym/widgets/digits_belt.dart';

class CodeEntryScreen extends StatefulWidget {
  const CodeEntryScreen({super.key});

  @override
  State<CodeEntryScreen> createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {
  final List<int?> _codeToEnter = [3, null, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7];
  late void Function(int) _handleKeyPressed;

  void _onKeyPressed(int digit) {
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
            digits: _codeToEnter,
            builder:
                (BuildContext context, void Function(int) handleKeyPressed) =>
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
