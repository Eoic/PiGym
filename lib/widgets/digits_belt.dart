import 'package:flutter/material.dart';
import 'package:pigym/data/guess.dart';
import 'package:pigym/data/pi.dart';

late double _kItemSize;
late double _kItemHorizontalMargin;
const int _kItemCount = 6;
const double _kItemMarginPercent = 0.12;
const double _kFocusedScale = 1.0;
const double _kUnfocusedScale = 1.0;
const int _kAnimationDurationMillis = 250;

typedef CustomBuilder =
    void Function(BuildContext context, Function(String) handleKeyPress);

class DigitsBelt extends StatefulWidget {
  final CustomBuilder builder;
  const DigitsBelt({super.key, required this.builder});

  @override
  State<DigitsBelt> createState() => _DigitsBeltState();
}

class _DigitsBeltState extends State<DigitsBelt> {
  int _currentIndex = 2;
  bool _isInitialized = false;
  ScrollController? _scrollController;
  final List<Guess> _guesses = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void validateAndAdvance(String digit) {
    if (digit == pi[_currentIndex]) {
      if (_currentIndex < piLength - 1) {
        setState(() {
          _currentIndex++;
          _guesses.add(Guess(digit: digit, isCorrect: true));
        });

        _scrollController!.animateTo(
          _getOffset(),
          duration: const Duration(milliseconds: _kAnimationDurationMillis),
          curve: Curves.easeInOut,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Done!'), backgroundColor: Colors.green),
        );
      }
    } else {
      setState(() {
        _guesses.add(Guess(digit: digit, isCorrect: false));
      });
    }
  }

  void handleKeyPressed(String digit) {
    validateAndAdvance(digit);
  }

  void _initializeValues(BuildContext context) {
    if (!_isInitialized) {
      final double realWidth = MediaQuery.of(context).size.width;
      _kItemSize =
          (realWidth - (realWidth * _kItemMarginPercent)) / _kItemCount;
      _kItemHorizontalMargin =
          (realWidth - _kItemSize * _kItemCount) / (2 * _kItemCount);
      _scrollController = ScrollController(initialScrollOffset: _getOffset());
      _isInitialized = true;
    }
  }

  double _getOffset() {
    return _currentIndex * _kItemSize +
        _kItemHorizontalMargin * 2 * (_currentIndex + 1);
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, handleKeyPressed);
    _initializeValues(context);

    if (!_isInitialized || _scrollController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final double horizontalPadding =
        (MediaQuery.of(context).size.width - _kItemSize) / 2 +
        _kItemHorizontalMargin;

    return SizedBox(
      height: _kItemSize * _kFocusedScale,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: piLength,
        itemBuilder: (context, index) {
          final bool isFocused = index == _currentIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: _kAnimationDurationMillis),
            curve: Curves.easeInOut,
            width: _kItemSize * (isFocused ? _kFocusedScale : _kUnfocusedScale),
            margin: EdgeInsets.symmetric(horizontal: _kItemHorizontalMargin),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  isFocused
                      ? Theme.of(context).colorScheme.secondary
                      : const Color(0xFF334351),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Transform.scale(
                scale: isFocused ? _kFocusedScale : _kUnfocusedScale,
                child: Text(
                  pi[index],
                  style: TextStyle(
                    color: Colors.white.withAlpha(150),
                    fontSize: 52,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'MadimiOne',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
