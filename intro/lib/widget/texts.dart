import 'package:flutter/material.dart';

// 섹션 제목 텍스트

class SectionText extends StatelessWidget {
  final String text;
  final Color textColor;
  const SectionText({super.key, required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
