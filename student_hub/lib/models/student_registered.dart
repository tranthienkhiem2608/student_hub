import 'package:student_hub/models/student_user.dart';

class StudentRegistered{
  final StudentUser student;
  final String levelStudent;
  final String introductionStudent;
  final String statusStudent;
  final bool isMessage;

  StudentRegistered({
    required this.student,
    required this.levelStudent,
    required this.introductionStudent,
    required this.statusStudent,
    required this.isMessage,
  });

  Map<String, dynamic> toMapStudentRegistered() {
    return {
      'student': student.toMapStudentUser(),
      'levelStudent': levelStudent,
      'introductionStudent': introductionStudent,
      'statusStudent': statusStudent,
      'isMessage': isMessage,
    };
  }

  factory StudentRegistered.fromMapStudentRegistered(Map<String, dynamic> map) {
    return StudentRegistered(
      student: StudentUser.fromMapStudentUser(map['student']),
      levelStudent: map['levelStudent'],
      introductionStudent: map['introductionStudent'],
      statusStudent: map['statusStudent'],
      isMessage: map['isMessage'],
    );
  }

}