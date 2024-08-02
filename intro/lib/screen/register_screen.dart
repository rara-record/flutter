import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intro/widget/appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intro/widget/text_fields.dart';
import 'package:intro/widget/texts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? profileImg;
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _passwordReController = TextEditingController();
  // final TextEditingController _introduceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Food PICK 가입하기',
        isLeading: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 사진
            GestureDetector(
                child: _buildProfile(),
                // 프로필 이미지 변경 및 삭체 팝업 띄우기
                onTap: () {
                  showBottomSheetAboutProfile();
                }),

            const SizedBox(height: 16),

            // 섹션 및 입력 필드들
            const SectionText(text: '닉네임', textColor: Color(0xff979797)),
            const SizedBox(height: 8),
            TextFormFieldCustom(
              hintText: '닉네임을 입력해주세요',
              isPasswordField: false,
              isReadOnly: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (value) => inputNameValidator(value),
              controller: _nameController,
            ),

            const SizedBox(height: 16),

            const SectionText(text: '이메일', textColor: Color(0xff979797)),

            const SizedBox(height: 16),
            const SectionText(text: '비밀번호', textColor: Color(0xff979797)),

            const SizedBox(height: 16),
            const SectionText(text: '비밀번호 확인', textColor: Color(0xff979797)),

            const SizedBox(height: 16),
            const SectionText(text: '자기소개', textColor: Color(0xff979797)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    if (profileImg == null) {
      // 이미지가 없을 경우
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
    } else {
      // 이미지가 존재할 경우
      return Center(
        child: CircleAvatar(
          radius: 48,
          backgroundColor: Colors.grey,
          backgroundImage: FileImage(profileImg!),
        ),
      );
    }
  }

  void showBottomSheetAboutProfile() {
    showModalBottomSheet(
      context: context,
      // 위젯 뱉어주기
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 사진 촬영 버튼
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  getCameraImage();
                },
                child: const Text('사진 촬영',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    )),
              ),
              // 앨범에서 사진 선택
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  getGalleryImage();
                },
                child: const Text('앨범에서 사진 선택',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    )),
              ),
              // 프로필 사진 삭제
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  deleteProfileImage();
                },
                child: const Text('프로필 사진 삭제',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getCameraImage() async {
    // 카메라로 사진 촬영하여 이미지 파일을 가져오는 함수
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    if (image != null) {
      setState(() {
        profileImg = File(image.path);
      });
    }
  }

  Future<void> getGalleryImage() async {
    // 앨범에서 사진 선택하는 함수
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    if (image != null) {
      setState(() {
        profileImg = File(image.path);
      });
    }
  }

  void deleteProfileImage() {
    // 프로필 사진 삭제
    setState(() {
      profileImg = null;
    });
  }

  inputNameValidator(value) {
    // 닉네임 필드 검증 함수
    if (value.isEmpty) {
      return 'ㄴ닉네임을 입력해주세요';
    }
  }
}
