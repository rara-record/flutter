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
        title: '안녕',
        isLeading: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('회원가입 화면'),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('뒤로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
