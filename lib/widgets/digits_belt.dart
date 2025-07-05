import 'package:flutter/material.dart';
import 'package:pigym/data/pi.dart';

const double _kItemSize = 125.0;
const double _kFocusedScale = 1.0;
const double _kUnfocusedScale = 1.0;
const double _kItemHorizontalMargin = 8.0;
const int _kAnimationDurationMillis = 250;

typedef CustomBuilder =
    void Function(BuildContext context, Function(String) handleKeyPress);

class DigitsBelt extends StatefulWidget {
  final CustomBuilder builder;
  const DigitsBelt({super.key, required this.builder });

  @override
  State<DigitsBelt> createState() => _DigitsBeltState();
}

class _DigitsBeltState extends State<DigitsBelt> {
  int _currentIndex = 2;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: _currentIndex * _kItemSize + 2 * _kItemHorizontalMargin * (_currentIndex + 1),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void validateAndAdvance(String digit) {
    if (digit == pi[_currentIndex]) {

      // TODO: Do not calculate length each time.
      if (_currentIndex < pi.length - 1) {
        setState(() {
          _currentIndex++;
        });

        _scrollController.animateTo(
          // Pushes the belt to the left by item size * index.
          _currentIndex * _kItemSize + _kItemHorizontalMargin * 2 * (_currentIndex + 1),
          duration: const Duration(milliseconds: _kAnimationDurationMillis),
          curve: Curves.easeInOut,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Done!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      //   TODO: Handle incorrect press.
    }
  }

  void handleKeyPressed(String digit) {
    validateAndAdvance(digit);
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, handleKeyPressed);

    final double horizontalPadding =
        (MediaQuery.of(context).size.width - _kItemSize) / 2 + _kItemHorizontalMargin;

    return SizedBox(
      height: _kItemSize * _kFocusedScale,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        // TODO: Calculate length in advance.
        itemCount: pi.length,
        itemBuilder: (context, index) {
          final bool isFocused = index == _currentIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: _kAnimationDurationMillis),
            curve: Curves.easeInOut,
            width: _kItemSize,
            margin: const EdgeInsets.symmetric(horizontal: _kItemHorizontalMargin),
            // margin: const EdgeInsets.symmetric(horizontal: 4.0),
            transform:
                Matrix4.identity()
                  ..scale(isFocused ? _kFocusedScale : _kUnfocusedScale),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  isFocused
                      ? Theme.of(context).colorScheme.secondary
                      : const Color(0xFF334351),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Text(
                pi[index],
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
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
