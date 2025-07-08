import 'package:flutter/material.dart';
import 'package:pigym/data/guess.dart';

class DigitsHistory extends StatefulWidget {
  final List<Guess> digits;

  const DigitsHistory({super.key, required this.digits});

  @override
  State<DigitsHistory> createState() => _DigitsHistoryState();
}

class _DigitsHistoryState extends State<DigitsHistory> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
  }

  @override
  void didUpdateWidget(DigitsHistory oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.digits.length != oldWidget.digits.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _scrollToEnd();
        }
      });
    }
  }

  void _scrollToEnd() {
    if (_scrollController.hasClients && widget.digits.isNotEmpty) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.centerRight,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: widget.digits.length,
          itemBuilder: (context, index) {
            final itemIndex = widget.digits.length - 1 - index;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  widget.digits[itemIndex].digit.toString(),
                  style: TextStyle(fontSize: 20, color: widget.digits[itemIndex].isCorrect ? Colors.green : Colors.red,),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}