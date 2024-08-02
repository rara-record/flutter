import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLeading; // 백버튼 존재 여부
  final Function? onTabBackButton; // 뒤로가기 버튼 액션 정의
  final List<Widget>? actions; // 앱바 우측에 버튼이 필요할 때 정의

  const CommonAppBar({
    super.key,
    required this.title,
    required this.isLeading,
    this.onTabBackButton,
    this.actions,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height); // AppBar 높이 설정

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
