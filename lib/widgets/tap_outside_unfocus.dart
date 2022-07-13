import 'package:flutter/material.dart';

/// Simple wrapper that will clear focus when a tap is detected outside
/// its boundaries
class TapOutsideUnfocus extends StatelessWidget {
  const TapOutsideUnfocus({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Clear focus of our fields when tapped in this empty space
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
