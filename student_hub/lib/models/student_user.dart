//import model for student user
import 'package:student_hub/models/project_student.dart';
import 'package:student_hub/models/project_student.dart';
class StudentUser {
  final String fullName;
  final String email;
  final String password;
  final String typeUser = 'student';
  final String techStack;
  final List<String> skillsList;
  final List<Map<String, dynamic>> languagesList;
  final List<Map<String, dynamic>> educationList;
  final List<ProjectStudent> projectsList;

  StudentUser({
    required this.fullName,
    required this.email,
    required this.password,
    required this.techStack,
    required this.skillsList,
    required this.languagesList,
    required this.educationList,
    required this.projectsList,
  });

  Duration get duration => projectsList.fold(
    Duration.zero,
    (previousValue, element) => previousValue + element.timeEnd.difference(element.timeStart),
  );

  Map<String, dynamic> toMapStudentUser() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'typeUser': typeUser,
      'techStack': techStack,
      'skillsList': skillsList,
      'languagesList': languagesList,
      'educationList': educationList,
      'projectsList': projectsList,
    };
  }

  factory StudentUser.fromMapStudentUser(Map<String, dynamic> map) {
    return StudentUser(
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      techStack: map['techStack'],
      skillsList: map['skillsList'],
      languagesList: map['languagesList'],
      educationList: map['educationList'],
      projectsList: map['projectsList'],
    );
  }

}

List<StudentUser> projectList = [
  StudentUser(
    fullName: 'John Doe',
    email: 'johnDoe12@gmail.com',
    password: 'password123',
    techStack: 'Flutter, Dart, Java, Kotlin, Python, C++, C#, Swift, React, Angular, Vue, Node.js, Express.js, MongoDB, Firebase',
    skillsList: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
    languagesList: [
      {
        'language': 'English',
        'proficiency': 'Native'
      },
      {
        'language': 'Spanish',
        'proficiency': 'Conversational'
      },
    ],
    educationList: [
      {
        'school': 'University of Florida',
        'degree': 'Bachelor of Science in Computer Science',
        'graduationDate': '2023-05-01',
      },
      {
        'school': 'University of Florida',
        'degree': 'Bachelor of Science in Computer Science',
        'graduationDate': '2023-05-01',
      },
    ],
    projectsList: [
      ProjectStudent(
        projectName: 'Project 1',
        projectDescription: 'This is a project 1 description',
        timeStart: DateTime.parse('2021-10-01'),
        timeEnd: DateTime.parse('2021-11-21'),
        skillsListProject: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
      ),
      ProjectStudent(
        projectName: 'Project 2',
        projectDescription: 'This is a project description',
        timeStart: DateTime.parse('2019-05-03'),
        timeEnd: DateTime.parse('2019-06-21'),
        skillsListProject: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
      ),
      ProjectStudent(
        projectName: 'Project 3',
        projectDescription: 'This is a project description',
        timeStart: DateTime.parse('2020-01-01'),
        timeEnd: DateTime.parse('2020-02-21'),
        skillsListProject: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
      ),
      ProjectStudent(
        projectName: 'Project 4',
        projectDescription: 'This is a project description',
        timeStart: DateTime.parse('2020-01-01'),
        timeEnd: DateTime.parse('2020-02-21'),
        skillsListProject: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
      ),
    ],
  ),
  StudentUser(
    fullName: 'Jane Dane',
    email: 'jd123@gmail.com',
    password: 'password123',
    techStack: 'Flutter, Dart, Java, Kotlin, Python, C++, C#, Swift, React, Angular, Vue, Node.js, Express.js, MongoDB, Firebase',
    skillsList: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
    languagesList: [
      {
        'language': 'English',
        'proficiency': 'Native'
      },
      {
        'language': 'Spanish',
        'proficiency': 'Conversational'
      },
    ],
    educationList: [
      {
        'school': 'University of Florida',
        'degree': 'Bachelor of Science in Computer Science',
        'graduationDate': '2023-05-01',
      },
      {
        'school': 'University of Florida',
        'degree': 'Bachelor of Science in Computer Science',
        'graduationDate': '2023-05-01',
      },
    ],
    projectsList: [
      ProjectStudent(
        projectName: 'Project 1',
        projectDescription: 'This is a project 1 description',
        timeStart: DateTime.parse('2021-10-01'),
        timeEnd: DateTime.parse('2021-11-21'),
        skillsListProject: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
      ),
      ProjectStudent(
        projectName: 'Project 2',
        projectDescription: 'This is a project description',
        timeStart: DateTime.parse('2019-05-03'),
        timeEnd: DateTime.parse('2019-06-21'),
        skillsListProject: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
      ),
      ProjectStudent(
        projectName: 'Project 3',
        projectDescription: 'This is a project description',
        timeStart: DateTime.parse('2020-01-01'),
        timeEnd: DateTime.parse('2020-02-21'),
        skillsListProject: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
      ),
      ProjectStudent(
        projectName: 'Project 4',
        projectDescription: 'This is a project description',
        timeStart: DateTime.parse('2020-01-01'),
        timeEnd: DateTime.parse('2020-02-21'),
        skillsListProject: ['Flutter', 'Dart', 'Java', 'Kotlin', 'Python', 'C++', 'C#', 'Swift', 'React', 'Angular', 'Vue', 'Node.js', 'Express.js', 'MongoDB', 'Firebase'],
      ),
    ],
  ),
];