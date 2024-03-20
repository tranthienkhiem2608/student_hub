import 'package:student_hub/models/student_user.dart';

class StudentRegistered{
  StudentUser student;
  String levelStudent;
  String introductionStudent;
  String statusStudent;
  bool isMessage;
  bool isHireOfferSent; // Add this field

  StudentRegistered({
    required this.student,
    required this.levelStudent,
    required this.introductionStudent,
    required this.statusStudent,
    required this.isMessage,
    this.isHireOfferSent = false, // Initialize it to false
  });

  Map<String, dynamic> toMapStudentRegistered() {
    return {
      'student': student.toMapStudentUser(),
      'levelStudent': levelStudent,
      'introductionStudent': introductionStudent,
      'statusStudent': statusStudent,
      'isMessage': isMessage,
      'isHireOfferSent': isHireOfferSent, // Add this field
    };
  }

  factory StudentRegistered.fromMapStudentRegistered(Map<String, dynamic> map) {
    return StudentRegistered(
      student: StudentUser.fromMapStudentUser(map['student']),
      levelStudent: map['levelStudent'],
      introductionStudent: map['introductionStudent'],
      statusStudent: map['statusStudent'],
      isMessage: map['isMessage'],
      isHireOfferSent: map['isHireOfferSent']?? false, // Add this field
    );
  }

}