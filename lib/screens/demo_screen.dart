import 'package:flutter/material.dart';
import 'package:pigym/data/guess.dart';
import 'package:pigym/widgets/digits_history.dart';
import 'package:pigym/widgets/keypad/keypad.dart';
import 'package:pigym/widgets/digits_belt.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final List<Guess> _guesses = [];
  late void Function(String) _handleKeyPressed;

  void _onKeyPressed(String digit) {
    _handleKeyPressed.call(digit);
  }

  void _addGuess(Guess guess) {
    setState(() {
      _guesses.add(guess);
    });
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
            addGuess: _addGuess,
          ),
          const Spacer(),
          DigitsHistory(digits: _guesses),
          const Spacer(),
          Keypad(onKeyPressed: _onKeyPressed),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
