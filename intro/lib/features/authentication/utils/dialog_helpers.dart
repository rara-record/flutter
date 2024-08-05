import 'package:flutter/material.dart';

class DialogHelpers {
  static Future<void> showSelectionDialog({
    required BuildContext context,
    required String title,
    required List<String> options,
    required void Function(String) onSelected,
    String? initialValue, // 처음 선택된 값을 받을 수 있는 인자를 추가합니다.
  }) async {
    await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        String? selectedValue = initialValue; // 선택된 값 초기화

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...options.map((String option) {
                  return ListTile(
                    title: Text(option),
                    trailing: selectedValue == option
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedValue = option; // 선택된 값을 업데이트
                      });
                      Navigator.pop(context, option);
                    },
                  );
                }),
                const SizedBox(height: 36),
              ],
            );
          },
        );
      },
    ).then((selectedValue) {
      if (selectedValue != null) {
        onSelected(selectedValue);
      }
    });
  }

  /// 생년월일 선택을 위한 DatePicker 다이얼로그
  static Future<void> showDatePickerDialog({
    required BuildContext context,
    required Function(String) onSelected,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = "${picked.year}년${picked.month}월${picked.day}일";
      onSelected(formattedDate); // 선택된 날짜를 콜백으로 반환
    }
  }
}
