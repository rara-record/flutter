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
