import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/models/model/student_user.dart';

class Experience{
  final String id;
  final StudentUser studentId;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<SkillSets> skillSet;
  final String description;

  Experience({
    required this.id,
    required this.studentId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.skillSet,
    required this.description,
  });

  Map<String, dynamic> toMapExperience() {
    return {
      'id': id,
      'student_id': studentId.toMapStudentUser(),
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'skillSet': skillSet,
      'description': description,
    };
  }

  factory Experience.fromMapExperience(Map<String, dynamic> map) {
    return Experience(
      id: map['id'],
      studentId: StudentUser.fromMapStudentUser(map['student_id']),
      title: map['title'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      skillSet: map['skillSet'],
      description: map['description'],
    );
  }
}