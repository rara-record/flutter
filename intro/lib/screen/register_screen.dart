import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intro/widget/appbar.dart';
import 'package:image_picker/image_picker.dart';

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
          ),
        );
      },
    );
  }

  Future<void> getCameraImage() async {
    // 카메라로 사진 촬영하여 이미지 파일을 가져오는 함수
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        profileImg = File(image.path);
      });
    }
  }
}
