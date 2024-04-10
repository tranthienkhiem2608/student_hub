import 'package:flutter/foundation.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/models/model/techStack.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/model/experience.dart';

class StudentUser {
  int? id;
  final String? createAt;
  final String? updatedAt;
  final String? deletedAt;
  int? userId;
  int? techStack;
  List<int>? skillSet;
  List<Language>? languages;
  List<Education>? education;
  List<Experience>? experience;

  StudentUser({
    this.id,
    this.createAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.techStack,
    this.skillSet,
    this.languages,
    this.education,
    this.experience,
  });
  Duration? get duration => experience?.fold(
        Duration.zero,
        (previousValue, element) =>
            previousValue! + element.endMonth!.difference(element.startMonth!),
      );

  Map<String, dynamic> toMapStudentUser() => {
        'id': id,
        'createAt': createAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'userId': userId,
        'techStack': techStack,
        'skillSet': skillSet,
        'languages': languages?.map((e) => e.toMapLanguage()).toList(),
        'education': education?.map((e) => e.toMapEducation()).toList(),
        'experience': experience?.map((e) => e.toMapExperience()).toList(),
      };

  factory StudentUser.fromMapStudentUser(Map<String, dynamic> map) {
    return StudentUser(
      id: map['id'],
      createAt: map['createAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      userId: map['userId'],
      techStack: map['techStack'],
      skillSet: List<int>.from(map['skillSet']),
      languages: List<Language>.from(
          map['languages'].map((e) => Language.fromMapLanguage(e))),
      education: List<Education>.from(
          map['education'].map((e) => Education.fromMapEducation(e))),
      experience: List<Experience>.from(
          map['experience'].map((e) => Experience.fromMapExperience(e))),
    );
  }
}
