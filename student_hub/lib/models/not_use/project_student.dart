class ProjectStudent{
  final String projectName;
  final String projectDescription;
  final DateTime timeStart;
  final DateTime timeEnd;
  final List<String> skillsListProject;

  ProjectStudent({
    required this.projectName,
    required this.projectDescription,
    required this.timeStart,
    required this.timeEnd,
    required this.skillsListProject,
  });

  Map<String, dynamic> toMapProjectStudent() {
    return {
      'projectName': projectName,
      'projectDescription': projectDescription,
      'timeStart': timeStart.toIso8601String(),
      'timeEnd': timeEnd.toIso8601String(),
      'skillsList': skillsListProject,
    };
  }
  factory ProjectStudent.fromMapProjectStudent(Map<String, dynamic> map) {
    return ProjectStudent(
      projectName: map['projectName'],
      projectDescription: map['projectDescription'],
      timeStart: DateTime.parse(map['timeStart']),
      timeEnd: DateTime.parse(map['timeEnd']),
      skillsListProject: map['skillsList'],
    );
  }
}
