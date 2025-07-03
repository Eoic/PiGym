import 'package:flutter/material.dart';

const double _kItemSize = 80.0;
const double _kFocusedScale = 1.15;
const double _kUnfocusedScale = 1.0;
const int _kAnimationDurationMillis = 350;

class CodeEntryScreen extends StatefulWidget {
  const CodeEntryScreen({super.key});

  @override
  State<CodeEntryScreen> createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {
  final List<int> _codeToEnter = [1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7];
  final GlobalKey<_DigitScrollerState> _digitScrollerKey = GlobalKey();

  void _onKeyPressed(int digit) {
    _digitScrollerKey.currentState?.validateAndAdvance(digit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter the Code'),
        backgroundColor: const Color(0xFF2D3238),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          DigitScroller(key: _digitScrollerKey, digits: _codeToEnter),
          const Spacer(),
          Keypad(onKeyPressed: _onKeyPressed),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DigitScroller extends StatefulWidget {
  final List<int> digits;

  const DigitScroller({super.key, required this.digits});

  @override
  State<DigitScroller> createState() => _DigitScrollerState();
}

class _DigitScrollerState extends State<DigitScroller> {
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
    //   TODO: Handle incorrect pres.
    }
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
        (MediaQuery.of(context).size.width - _kItemSize) / 2;

    return SizedBox(
      height:
          _kItemSize * _kFocusedScale,
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
                      ? const Color(0xFF6A3A4C)
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
          fontSize: 34,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }
}
