import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intro/features/authentication/utils/dialog_helpers.dart';
import 'package:intro/widget/buttons.dart';

import '../models/user_details.dart';

// 가입 프로세스의 각 단계를 정의합니다.
enum RegisterStep { step1, step2, step3, step4 }

class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 현재 스텝
    final currentStep = useState(RegisterStep.step1);

    // 사용자 입력 데이터
    final userDetails = useState(UserDetails(
        name: '', birthDate: '', gender: '', nationality: '', phoneNumber: ''));

    // 각 필드에 대한 컨트롤러
    final nameController =
        useTextEditingController(text: userDetails.value.name);
    final birthDateController =
        useTextEditingController(text: userDetails.value.birthDate);
    final genderController =
        useTextEditingController(text: userDetails.value.gender);
    final phoneNumberController =
        useTextEditingController(text: userDetails.value.phoneNumber);

    // FocusNode 생성
    final nameFocusNode = useFocusNode();
    final birthDateFocusNode = useFocusNode();
    final genderFocusNode = useFocusNode();
    final phoneNumberFocusNode = useFocusNode();

    // 스텝 변경 시 포커스를 관리하는 함수
    void manageFocus() {
      // 모든 포커스를 해제
      nameFocusNode.unfocus();
      birthDateFocusNode.unfocus();
      genderFocusNode.unfocus();
      phoneNumberFocusNode.unfocus();

      // 현재 스텝에 따라 포커스를 설정
      WidgetsBinding.instance.addPostFrameCallback((_) {
        switch (currentStep.value) {
          case RegisterStep.step1:
            FocusScope.of(context).requestFocus(nameFocusNode);
            break;
          case RegisterStep.step2:
            FocusScope.of(context).requestFocus(birthDateFocusNode);
            break;
          case RegisterStep.step3:
            FocusScope.of(context).requestFocus(genderFocusNode);
            break;

          case RegisterStep.step4:
            FocusScope.of(context).requestFocus(phoneNumberFocusNode);
            break;
        }
      });
    }

    // 스텝이 변경될 때마다 manageFocus 함수 호출
    useEffect(() {
      manageFocus();
      return null;
    }, [currentStep.value]);

    // 현재 스텝에 따라 섹션 제목을 반환하는 함수
    String getSectionText() {
      switch (currentStep.value) {
        case RegisterStep.step1:
          return '이름을 알려주세요';
        case RegisterStep.step2:
          return '생년월일을 입력해주세요';
        case RegisterStep.step3:
          return '성별을 선택해주세요';
        case RegisterStep.step4:
          return '휴대폰 번호를 입력해주세요';
      }
    }

    // 다음 스텝으로 이동하는 함수
    void goToNextStep(String? selectedData) {
      switch (currentStep.value) {
        case RegisterStep.step1:
          // 사용자가 이름을 입력한 후 다음 스텝으로 넘어갈 때 입력한 이름을 저장
          userDetails.value =
              userDetails.value.copyWith(name: nameController.text);
          currentStep.value = RegisterStep.step2;
          break;
        case RegisterStep.step2:
          // 사용자가 생년월일을 입력한 후 다음 스텝으로 넘어갈 때 입력한 생년월일을 저장
          birthDateController.text = selectedData ?? '';
          userDetails.value =
              userDetails.value.copyWith(birthDate: birthDateController.text);
          currentStep.value = RegisterStep.step3;
          break;
        case RegisterStep.step3:
          genderController.text = selectedData ?? '';
          userDetails.value =
              userDetails.value.copyWith(gender: genderController.text);
          currentStep.value = RegisterStep.step4;
          break;
        case RegisterStep.step4:
          // 사용자가 휴대폰 번호를 입력한 후 마지막 스텝으로 넘어갈 때 입력한 번호를 저장
          userDetails.value = userDetails.value
              .copyWith(phoneNumber: phoneNumberController.text);
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

    // 생년월일 선택기
    Future<void> selectBirthDate(BuildContext context) async {
      await DialogHelpers.showDatePickerDialog(
        context: context,
        onSelected: (String selectedDate) {
          goToNextStep(selectedDate); // 선택 후 다음 스텝으로 이동
        },
      );
    }

    // 성별 선택기
    Future<void> selectGender(BuildContext context) async {
      await DialogHelpers.showSelectionDialog(
        context: context,
        title: "성별을 알려주세요", // 섹션 타이틀 추가
        options: ["남성", "여성"],
        initialValue: userDetails.value.gender,
        onSelected: (String selectedGender) {
          goToNextStep(selectedGender); // 선택 후 다음 스텝으로 이동
        },
      );
    }

    // 각 스텝에 맞는 텍스트 필드를 반환하는 함수 (역순으로 추가)
    // 텍스트 필드에 포커스를 주거나 텍스트를 입력하면 힌트 텍스트가 라벨 텍스트로 전환되는 방식으로 동작합니다.
    List<Widget> getTextFieldWidgets() {
      List<Widget> fields = [];

      // Step1: 이름 입력 필드
      fields.add(TextFormField(
        focusNode: nameFocusNode,
        controller: nameController, // 이전에 입력된 값 유지
        decoration: InputDecoration(
          hintText: '이름',
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: nameFocusNode.hasFocus || nameController.text.isNotEmpty
              ? '이름'
              : null,
          labelStyle: TextStyle(
            color: nameFocusNode.hasFocus
                ? Colors.blue
                : Colors.black54, // 포커스 시 색상 변경
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ));

      // Step2: 생년월일 선택 필드
      if (currentStep.value.index >= RegisterStep.step2.index) {
        fields.insert(
          0,
          GestureDetector(
            onTap: () => selectBirthDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: birthDateController, // 이전에 입력된 값 유지
                decoration: InputDecoration(
                  hintText: '생년월일',
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelText:
                      birthDateController.text.isNotEmpty ? '생년월일' : null,
                  labelStyle: const TextStyle(color: Colors.black54),
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }

      // Step3: 성별 선택 필드
      if (currentStep.value.index >= RegisterStep.step3.index) {
        fields.insert(
          0,
          GestureDetector(
            onTap: () => selectGender(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: genderController, // 이전에 입력된 값 유지
                decoration: InputDecoration(
                  hintText: '성별',
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelText: genderController.text.isNotEmpty ? '성별' : null,
                  labelStyle: const TextStyle(color: Colors.black54),
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }

      // Step4: 휴대폰 번호 입력 필드
      if (currentStep.value.index >= RegisterStep.step4.index) {
        fields.insert(
          0,
          TextFormField(
            focusNode: phoneNumberFocusNode,
            controller: phoneNumberController, // 이전에 입력된 값 유지
            keyboardType: TextInputType.number, // 숫자 키패드 설정
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능하게 필터 설정
            ],
            decoration: InputDecoration(
              hintText: '휴대폰 번호',
              hintStyle: const TextStyle(color: Colors.grey),
              labelText: phoneNumberFocusNode.hasFocus ||
                      nameController.text.isNotEmpty
                  ? '휴대폰 번호'
                  : null,
              labelStyle: TextStyle(
                color: nameFocusNode.hasFocus
                    ? Colors.blue
                    : Colors.black54, // 포커스 시 색상 변경
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                  goToNextStep('');
                }),
          ),
        ));
  }
}
