import 'package:student_hub/models/model/student_user.dart';

class Language{
  final String id;
  final StudentUser studentId;
  final String languageName;
  final String level;

  Language({
    required this.id,
    required this.studentId,
    required this.languageName,
    required this.level,
  });

  Map<String, dynamic> toMapLanguage() {
    return {
      'id': id,
      'student_id': studentId.toMapStudentUser(),
      'languageName': languageName,
      'level': level,
    };
  }


  factory Language.fromMapLanguage(Map<String, dynamic> map) {
    return Language(
      id: map['id'],
      studentId: StudentUser.fromMapStudentUser(map['student_id']),
      languageName: map['languageName'],
      level: map['level'],
    );
  }

  static fromListMap(List<Map<String, dynamic>> languages) {
    return languages.map((e) => Language.fromMapLanguage(e)).toList();
  }

}