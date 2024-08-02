import 'package:flutter/material.dart';
import 'package:intro/widget/appbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                onTap: () {})
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
}
