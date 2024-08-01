import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String text; // 버튼 텍스트
  final Color backgroundColor; // 버튼 배경 색상
  final Color textColor; // 버튼 텍스트 색상
  final Function onPressed; // 버튼 클릭 신호

  const ElevatedButtonCustom({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  // **ButtonStyle**은 버튼의 상태별 스타일을 세밀하게 제어할 수 있는 고급 방법입니다.
  // **ElevatedButton.styleFrom**은 간편하게 기본적인 스타일을 적용하는 데 유용한 방법입니다.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed.call(),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
