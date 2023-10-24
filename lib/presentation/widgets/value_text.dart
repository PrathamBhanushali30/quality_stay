import 'package:flutter/material.dart';

class ValueText extends StatelessWidget {
  const ValueText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black.withAlpha(95),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
