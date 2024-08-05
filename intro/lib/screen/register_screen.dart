import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intro/widget/buttons.dart';

// 가입 프로세스의 각 단계를 정의합니다.
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
    ); // 사용자 입력 데이터

    // 현재 스텝에 따라 섹션 제목을 반환하는 함수
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

    // 각 스텝에 맞는 텍스트 필드를 반환하는 함수 (역순으로 추가)
    List<Widget> getTextFieldWidgets() {
      List<Widget> fields = [];

      // Step1: 이름 입력 필드
      fields.add(
        TextFormField(
          initialValue: userDetails.value.name,
          decoration: const InputDecoration(hintText: '이름을 입력해주세요'),
          onChanged: (value) {
            userDetails.value = userDetails.value.copyWith(name: value);
          },
        ),
      );

      // Step2: 생년월일 입력 필드
      if (currentStep.value.index >= RegisterStep.step2.index) {
        fields.insert(
          0,
          TextFormField(
            initialValue: userDetails.value.birthDate,
            decoration: const InputDecoration(hintText: '생년월일을 입력해주세요'),
            onChanged: (value) {
              userDetails.value = userDetails.value.copyWith(birthDate: value);
            },
          ),
        );
      }

      // Step3: 성별 선택 필드
      if (currentStep.value.index >= RegisterStep.step3.index) {
        fields.insert(
          0,
          DropdownButtonFormField<String>(
            value: userDetails.value.gender.isEmpty
                ? null
                : userDetails.value.gender,
            hint: const Text('성별을 선택해주세요'),
            items: const [
              DropdownMenuItem(value: '남성', child: Text('남성')),
              DropdownMenuItem(value: '여성', child: Text('여성')),
              DropdownMenuItem(value: '기타', child: Text('기타')),
            ],
            onChanged: (value) {
              userDetails.value =
                  userDetails.value.copyWith(gender: value ?? '');
            },
          ),
        );
      }

      // Step4: 국적 선택 필드
      if (currentStep.value.index >= RegisterStep.step4.index) {
        fields.insert(
          0,
          DropdownButtonFormField<String>(
            value: userDetails.value.nationality.isEmpty
                ? null
                : userDetails.value.nationality,
            hint: const Text('국적을 선택해주세요'),
            items: const [
              DropdownMenuItem(value: '한국', child: Text('한국')),
              DropdownMenuItem(value: '미국', child: Text('미국')),
              DropdownMenuItem(value: '기타', child: Text('기타')),
            ],
            onChanged: (value) {
              userDetails.value =
                  userDetails.value.copyWith(nationality: value ?? '');
            },
          ),
        );
      }

      // Step5: 휴대폰 번호 입력 필드
      if (currentStep.value.index >= RegisterStep.step5.index) {
        fields.insert(
          0,
          TextFormField(
            initialValue: userDetails.value.phoneNumber,
            decoration: const InputDecoration(hintText: '휴대폰 번호를 입력해주세요'),
            onChanged: (value) {
              userDetails.value =
                  userDetails.value.copyWith(phoneNumber: value);
            },
          ),
        );
      }

      return fields;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // 현재 스텝에 맞는 제목 표시
                getSectionText(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ...getTextFieldWidgets(), // 이전 스텝에서의 필드도 모두 보여줌
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButtonCustom(
            text: '확인',
            backgroundColor: Colors.black,
            textColor: Colors.white,
            onPressed: () {
              goToNextStep(); // "확인" 버튼을 누르면 다음 스텝으로 이동
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

  // 필드들을 유지하면서 새로운 값을 업데이트하는 copyWith 메서드
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
