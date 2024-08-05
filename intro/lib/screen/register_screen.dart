import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intro/widget/buttons.dart';

// 이전 스텝의 일부 UI 요소가 그대로 남아있는 상태에서 다음 스텝으로 이동한다.
// 이전 단계에서 입력된 정보를 계속해서 유지하면서 추가적인 입력을 받는 구조

// 각 스텝마다 UI의 변화를 주면서 동일한 위젯을 업데이트 하고,
// 사용자가 이전에 입력한 정보는 유지하면서 새로운 정보를 입력할 수 있도록 한다.

// 예를 들어, 텍스트 필드와 설명 텍스트를 하나의 column에 두고, 이들의 내용을 변경해 나가는 방식이다.

// 주요 변경 사항:
// getSectionText: 현재 스텝에 따라 제목 텍스트를 변경합니다.
// getTextFieldWidget: 각 스텝에 맞는 텍스트 필드를 반환하며, 이전에 입력된 값을 유지하고 현재 스텝에 맞는 입력을 받습니다.
// goToNextStep: 다음 스텝으로 이동하며, 마지막 스텝에서 가입 절차를 완료합니다.
// 이 방식으로 구현하면, 화면 상에서 이전 스텝에서 입력한 내용이 계속 유지되며, 새로운 입력만 추가됩니다. 이미지에서 보여주신 흐름에 따라 섹션 텍스트와 입력 필드가 단계별로 업데이트됩니다.

enum RegisterStep { step1, step2, step3, step4, step5 }

class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(RegisterStep.step1); // 현재 스텝
    final userDetails = useState(
      UserDetails(
          name: '',
          birthDate: '',
          gender: '',
          nationality: '',
          phoneNumber: ''),
    );

    // 현재 스텝에 따라 제목 텍스트를 반환하는 함수
    String getSectionText() {
      switch (currentStep.value) {
        case RegisterStep.step1:
          return '이름을 입력해주세요';
        case RegisterStep.step2:
          return '생년월일을 입력해주세요';
        case RegisterStep.step3:
          return '성별을 선택해주세요';
        case RegisterStep.step4:
          return '국적을 선택해주세요';
        case RegisterStep.step5:
          return '휴대폰 번호를 입력해주세요';
      }
    }

    // 다음 스텝으로 이동하는 함수
    void goToNextStep() {
      switch (currentStep.value) {
        case RegisterStep.step1:
          currentStep.value = RegisterStep.step2;
          break;
        case RegisterStep.step2:
          currentStep.value = RegisterStep.step3;
          break;
        case RegisterStep.step3:
          currentStep.value = RegisterStep.step4;
          break;
        case RegisterStep.step4:
          currentStep.value = RegisterStep.step5;
          break;
        case RegisterStep.step5:
          // 마지막 스텝이므로 가입 절차 완료 처리
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("가입 완료"),
              content: const Text("가입 절차가 완료되었습니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // 필요하다면 추가적인 동작을 수행 (예: 다른 화면으로 이동)
                  },
                  child: const Text("확인"),
                ),
              ],
            ),
          );
          break;
      }
    }

    // 현재 스텝에 맞는 텍스트 필드를 반환하는 함수
    Widget getTextFieldWidget() {
      switch (currentStep.value) {
        case RegisterStep.step1:
          return TextFormField(
            initialValue: userDetails.value.name,
            decoration: const InputDecoration(hintText: '이름을 입력해주세요'),
            onChanged: (value) {
              userDetails.value = userDetails.value.copyWith(name: value);
            },
          );
        case RegisterStep.step2:
          return TextFormField(
            initialValue: userDetails.value.birthDate,
            decoration: const InputDecoration(hintText: '생년월일을 입력해주세요'),
            onChanged: (value) {
              userDetails.value = userDetails.value.copyWith(birthDate: value);
            },
          );
        case RegisterStep.step3:
          return TextFormField(
            initialValue: userDetails.value.gender,
            decoration: const InputDecoration(hintText: '성별을 입력해주세요'),
            onChanged: (value) {
              userDetails.value = userDetails.value.copyWith(gender: value);
            },
          );
        case RegisterStep.step4:
          return TextFormField(
            initialValue: userDetails.value.nationality,
            decoration: const InputDecoration(hintText: '국적을 입력해주세요'),
            onChanged: (value) {
              userDetails.value =
                  userDetails.value.copyWith(nationality: value);
            },
          );
        case RegisterStep.step5:
          return TextFormField(
            initialValue: userDetails.value.phoneNumber,
            decoration: const InputDecoration(hintText: '휴대폰 번호를 입력해주세요'),
            onChanged: (value) {
              userDetails.value =
                  userDetails.value.copyWith(phoneNumber: value);
            },
          );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // 현재 스텝에 맞는 제목 표시
              getSectionText(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            getTextFieldWidget(), // 현재 스텝에 맞는 텍스트 필드 표시
            const Spacer(),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 16),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButtonCustom(
            text: '확인',
            backgroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: () {
              goToNextStep();
            },
          ),
        ),
      ),
    );
  }
}

class UserDetails {
  final String name;
  final String birthDate;
  final String gender;
  final String nationality;
  final String phoneNumber;

  UserDetails({
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.nationality,
    required this.phoneNumber,
  });

  UserDetails copyWith({
    String? name,
    String? birthDate,
    String? gender,
    String? nationality,
    String? phoneNumber,
  }) {
    return UserDetails(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
