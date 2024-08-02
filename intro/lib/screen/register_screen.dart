import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intro/widget/appbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? profileImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Food PICK 가입하기',
        isLeading: true,
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
                child: _buildProfile(),
                // 프로필 이미지 변경 및 삭체 팝업 띄우기
                onTap: () {
                  showBottomSheetAboutProfile();
                })
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return const Center(
      child: CircleAvatar(
        radius: 48,
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.add_a_photo,
          size: 48,
          color: Colors.white,
        ),
      ),
    );
  }

  void showBottomSheetAboutProfile() {
    showModalBottomSheet(
      context: context,
      // 위젯 뱉어주기
      builder: (context) {
        return Column(
          children: [
            // 사진 촬영 버튼
            TextButton(
              onPressed: () {},
              child: const Text('사진 촬영',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
            ),
            // 앨범에서 사진 선택
            TextButton(
              onPressed: () {},
              child: const Text('앨범에서 사진 선택',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
            ),
            // 프로필 사진 삭제
            TextButton(
              onPressed: () {},
              child: const Text('프로필 사진 삭제',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
            ),
          ],
        );
      },
    );
  }
}
