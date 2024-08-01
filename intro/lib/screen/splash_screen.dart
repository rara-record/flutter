// 앱 실행시 이동되는 곳

import 'package:flutter/material.dart';
import 'package:intro/widget/appbar.dart';
import 'package:intro/widget/buttons.dart';
import 'package:intro/widget/texts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  // StatefulWidget을 상속하는 클래스는 반드시 createState() 메서드를 구현해야 합니다.
  // 이 메서드는 상태를 관리하는 State 객체를 반환하는 데 사용됩니다
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonAppbBar(
          title: '안녕하세요',
          isLeading: false,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SectionText(
              text: '이메일',
              textColor: Color(0xff979797),
            ),
            ElevatedButtonCustom(
              text: '테스트 버튼',
              backgroundColor: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                print('hi');
              },
            ),
          ],
        ),
      ),
    );
  }
}
