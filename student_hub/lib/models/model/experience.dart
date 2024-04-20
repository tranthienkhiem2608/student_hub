import 'package:student_hub/models/model/skillSets.dart';
import 'package:intl/intl.dart';

class Experience {
  final int? studentId;
  final int? id;
  final String? title;
  final DateTime? startMonth;
  final DateTime? endMonth;
  final String? description;
  final List<SkillSets>? skillSet;
  final String? createAt;
  final String? deletedAt;
  final String? updatedAt;
  final int? duration;

  Experience({
    this.studentId,
    this.id,
    this.title,
    this.startMonth,
    this.endMonth,
    this.description,
    this.skillSet,
    this.createAt,
    this.deletedAt,
    this.updatedAt,
    this.duration,
  });
  // Duration get duration {
  //   if (startMonth != null && endMonth != null) {
  //     return endMonth!.difference(startMonth!);
  //   }
  //   return Duration();
  // }

  Map<String, dynamic> toMapExperience() {
    return {
      'id': null,
      'title': title,
      'startMonth':
          DateFormat('MM-yyyy').format(DateTime.parse(startMonth.toString())),
      'endMonth':
          DateFormat('MM-yyyy').format(DateTime.parse(endMonth.toString())),
      'description': description,
      'skillSet': skillSet!.map((e) => e.id).toList(),
    };
  }

  factory Experience.fromMapExperience(Map<String, dynamic> map) {
    return Experience(
      studentId: map['studentId'],
      id: map['id'],
      title: map['title'],
      startMonth: map['startDate'],
      endMonth: map['endDate'],
      skillSet: List<SkillSets>.from(map['skillSets'].map((e) => SkillSets.fromMapSkillSets(e))),
      description: map['description'],
      createAt: map['createAt'],
      deletedAt: map['deletedAt'],
      updatedAt: map['updatedAt'],
    );
  }

  static fromListMap(List<Map<String, dynamic>> experienceList) {
    return experienceList.map((e) => Experience.fromMapExperience(e)).toList();
  }
}

// String dateString = '01-2024'; // Replace with your actual date string

// List<String> dateParts = dateString.split('-');
// int month = int.parse(dateParts[0]);
// int year = int.parse(dateParts[1]);

// DateTime date = DateTime(year, month);