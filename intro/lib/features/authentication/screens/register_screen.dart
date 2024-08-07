import 'package:flutter/material.dart';
import 'package:intro/widget/appbar.dart';

// 회원가입 화면
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 사용 중인 장치의 전체 화면 크기를 기준으로 결정
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CommonAppBar(
        title: '',
        isLeading: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: const RegiserStepper(),
        ),
      ),
    );
  }
}

class RegiserStepper extends StatefulWidget {
  const RegiserStepper({super.key});

  @override
  State<RegiserStepper> createState() => _RegiserStepperState();
}

class _RegiserStepperState extends State<RegiserStepper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Step> stepList = [
      Step(
        title: const Text(
          '이메일을 입력해주세요',
          style: TextStyle(fontSize: 22),
        ),
        content: Container(
          alignment: Alignment.centerLeft,
          child: const Text('Content for Step 1'),
        ),
      ),
      const Step(
        title: Text('Step 2 title'),
        content: Text('Content for Step 2'),
      ),
      const Step(
        title: Text('Step 3 title'),
        content: Text('Content for Step 2'),
      ),
    ];

    return Stepper(
      currentStep: _currentIndex,
      onStepCancel: () {
        if (_currentIndex > 0) {
          setState(() {
            _currentIndex -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_currentIndex <= 0) {
          setState(() {
            _currentIndex += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      steps: stepList,
    );
  }
}
