import 'package:flutter/material.dart';

class CommonAppbBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLeading; // 백버튼 존재 여부
  final Function? onTabBackButton; // 뒤로가기 버튼 액션 정의
  final List<Widget>? actions; // 앱바 우측에 버튼이 필요할 때 정의

  const CommonAppbBar({
    super.key,
    required this.title,
    required this.isLeading,
    this.onTabBackButton,
    this.actions,
  });

  @override
  Size get preferredSize => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isLeading, // 뒤로가기 여부
      titleSpacing: isLeading ? 0 : 16,
      leading: isLeading
          ? GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: Colors.red,
              ),
              onTap: () {
                onTabBackButton != null
                    ? onTabBackButton!.call()
                    : Navigator.pop(context);
              })
          : null, // 커스텀 위젯
      actions: actions,
      title: Text(title),
    );
  }
}
