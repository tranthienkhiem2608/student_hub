import 'package:flutter/material.dart';
import 'package:student_hub/models/model/student_user.dart';

class Education {
  final int? studentId;
  final int? id;
  final String? schoolName;
  final int? startYear;
  final int? endYear;
  final String? createAt;
  final String? deletedAt;
  final String? updatedAt;

  Education({
    this.studentId,
    this.id,
    this.schoolName,
    this.startYear,
    this.endYear,
    this.createAt,
    this.deletedAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMapEducation() => {
        'id': null,
        'schoolName': schoolName,
        'startYear': startYear,
        'endYear': endYear,
      };

  factory Education.fromMapEducation(Map<String, dynamic> map) {
    return Education(
      studentId: map['studentId'],
      id: map['id'],
      schoolName: map['schoolName'],
      startYear: map['startYear'],
      endYear: map['endYear'],
      createAt: map['createAt'],
      deletedAt: map['deletedAt'],
      updatedAt: map['updatedAt'],
    );
  }

  static fromListMap(List<Map<String, dynamic>> educationList) {
    return educationList.map((e) => Education.fromMapEducation(e)).toList();
  }
}
