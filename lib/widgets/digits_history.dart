import 'package:flutter/material.dart';

class DigitsHistory extends StatefulWidget {
  final List<int> digits;

  const DigitsHistory({super.key, required this.digits});

  @override
  State<DigitsHistory> createState() => _DigitsHistoryState();
}

class _DigitsHistoryState extends State<DigitsHistory> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Listen to widget updates to scroll to the end when new digits are added.
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
  }

  @override
  void didUpdateWidget(DigitsHistory oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the list of digits has changed, scroll to the end.
    if (widget.digits.length != oldWidget.digits.length) {
      // Schedule a scroll to the end after the frame has been built.
      // This ensures that the ListView has had a chance to update its layout.
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    }
  }

  void _scrollToEnd() {
    // Only scroll if there are items and the scroll controller is attached to a scroll view.
    if (_scrollController.hasClients && widget.digits.isNotEmpty) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Adjust height as needed
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        // To add new items from the right, we reverse the list for display
        // and then reverse the individual items' rendering order.
        // However, for simplicity and better performance with frequent updates,
        // it's often easier to just let the ListView add to the end and
        // programmatically scroll. If you strictly need items to appear
        // as if they are "pushed" from the right visually while maintaining
        // the natural list order, you might need a more complex setup
        // or a custom RenderObject.
        // For this example, we'll add to the end and scroll.
        itemCount: widget.digits.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                widget.digits[index].toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}