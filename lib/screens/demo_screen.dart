import 'package:flutter/material.dart';
import 'package:pigym/widgets/keypad/keypad.dart';

const double _kItemSize = 80.0;
const double _kFocusedScale = 1.0;
const double _kUnfocusedScale = 1.0;
const int _kAnimationDurationMillis = 350;

class CodeEntryScreen extends StatefulWidget {
  const CodeEntryScreen({super.key});

  @override
  State<CodeEntryScreen> createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {
  final List<int> _codeToEnter = [1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7];
  final GlobalKey<_DigitsBeltState> _digitScrollerKey = GlobalKey();

  void _onKeyPressed(int digit) {
    _digitScrollerKey.currentState?.validateAndAdvance(digit);
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
          DigitsBelt(key: _digitScrollerKey, digits: _codeToEnter),
          const Spacer(),
          Keypad(onKeyPressed: _onKeyPressed),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DigitsBelt extends StatefulWidget {
  final List<int> digits;

  const DigitsBelt({super.key, required this.digits});

  @override
  State<DigitsBelt> createState() => _DigitsBeltState();
}

class _DigitsBeltState extends State<DigitsBelt> {
  late final ScrollController _scrollController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void validateAndAdvance(int digit) {
    if (digit == widget.digits[_currentIndex]) {
      if (_currentIndex < widget.digits.length - 1) {
        setState(() {
          _currentIndex++;
        });

        _scrollController.animateTo(
          _currentIndex * _kItemSize,
          duration: const Duration(milliseconds: _kAnimationDurationMillis),
          curve: Curves.easeInOut,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code Correct!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      //   TODO: Handle incorrect press.
    }
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
        (MediaQuery.of(context).size.width - _kItemSize) / 2;

    return SizedBox(
      height: _kItemSize * _kFocusedScale,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: widget.digits.length,
        itemBuilder: (context, index) {
          final bool isFocused = index == _currentIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: _kAnimationDurationMillis),
            curve: Curves.easeInOut,
            width: _kItemSize,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            transform:
                Matrix4.identity()
                  ..scale(isFocused ? _kFocusedScale : _kUnfocusedScale),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  isFocused
                      ? Theme.of(context).colorScheme.secondary
                      : const Color(0xFF4A6572),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Text(
                widget.digits[index].toString(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
