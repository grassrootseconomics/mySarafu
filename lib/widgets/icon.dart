import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    this.src = 'assets/images/sarafu_logo.png',
  }) : super(key: key);

  final String src;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          src,
          height: 35,
        ),
      ),
    );
  }
}
