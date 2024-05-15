import 'package:student_hub/models/not_use/student_registered.dart';

class ProjectCompany {
  final String projectName;
  final DateTime creationTime;
  final String description;
  final String duration;
  final int studentRequired;
  final List<StudentRegistered> studentRegistered;
  ProjectCompany({
    required this.projectName,
    required this.creationTime,
    required this.description,
    required this.duration,
    required this.studentRequired,
    required this.studentRegistered,
  });

  Map<String, dynamic> toMapProjectCompany() {
    return {
      'projectName': projectName,
      'creationTime': creationTime.toIso8601String(),
      'description': description,
      'duration': duration,
      'studentRequired': studentRequired,
      'studentRegistered':
          studentRegistered.map((e) => e.toMapStudentRegistered()).toList(),
    };
  }

  factory ProjectCompany.fromMapProjectCompany(Map<String, dynamic> map) {
    return ProjectCompany(
      projectName: map['projectName'],
      creationTime: DateTime.parse(map['creationTime']),
      description: map['description'],
      duration: map['duration'],
      studentRequired: map['studentRequired'],
      studentRegistered: List<StudentRegistered>.from(map['studentRegistered']
          .map((e) => StudentRegistered.fromMapStudentRegistered(e))),
    );
  }
}
