import 'package:flutter/material.dart';
import 'package:student_hub/models/model/student_user.dart';

class Education{
  final int id;
  final StudentUser studentId;
  final String schoolName;
  final YearPicker startYear;
  final YearPicker endYear;

  Education({
    required this.id,
    required this.studentId,
    required this.schoolName,
    required this.startYear,
    required this.endYear,
  });

  Map<String, dynamic> toMapEducation() {
    return {
      'id': id,
      'student_id': studentId.toMapStudentUser(),
      'schoolName': schoolName,
      'startYear': startYear,
      'endYear': endYear,
    };
  }

  factory Education.fromMapEducation(Map<String, dynamic> map) {
    return Education(
      id: map['id'],
      studentId: StudentUser.fromMapStudentUser(map['student_id']),
      schoolName: map['schoolName'],
      startYear: map['startYear'],
      endYear: map['endYear'],
    );
  }

  static fromListMap(List<Map<String, dynamic>> educationList) {
    return educationList.map((e) => Education.fromMapEducation(e)).toList();
  }
}