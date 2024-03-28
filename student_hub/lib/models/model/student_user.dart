import 'package:flutter/foundation.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/models/model/techStack.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/model/experience.dart';


class StudentUser{
  String id;
  User userId;
  TechStack? techStack;
  List<SkillSets>? skillSet;
  List<Language>? languages;
  List<Education>? education;
  List<Experience>? experience;

  StudentUser({
    required this.id,
    required this.userId,
     this.techStack,
     this.skillSet,
     this.languages,
     this.education,
      this.experience,
  });

  Map<String, dynamic> toMapStudentUser() {
    return {
      'id': id,
      'userId': userId.toMapUser(),
      'techStack': techStack?.toMapTechStack(),
      'skillSet': skillSet?.map((e) => e.toMapSkillSets()).toList(),
      'languages': languages?.map((e) => e.toMapLanguage()).toList(),
      'education': education?.map((e) => e.toMapEducation()).toList(),
      'experience': experience?.map((e) => e.toMapExperience()).toList(),
    };
  }

  factory StudentUser.fromMapStudentUser(Map<String, dynamic> map) {
    return StudentUser(
      id: map['id'],
      userId: User.fromMapUser(map['userId']),
      techStack: TechStack.fromMapTechStack(map['techStack']),
      skillSet: List<SkillSets>.from(map['skillSet'].map((e) => SkillSets.fromMapSkillSets(e))),
      languages: List<Language>.from(map['languages'].map((e) => Language.fromMapLanguage(e))),
      education: List<Education>.from(map['education'].map((e) => Education.fromMapEducation(e))),
      experience: List<Experience>.from(map['experience'].map((e) => Experience.fromMapExperience(e))),
    );
  }

}