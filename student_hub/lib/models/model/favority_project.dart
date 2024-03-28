import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/student_user.dart';

class FavorityPoject{
  final String id;
  final StudentUser studentId;
  final ProjectCompany projectId;

  FavorityPoject({
    required this.id,
    required this.studentId,
    required this.projectId,
  });

  Map<String, dynamic> toMapFavorityPoject() {
    return {
      'id': id,
      'studentId': studentId.toMapStudentUser(),
      'projectId': projectId.toMapProjectCompany(),
    };
  }

  factory FavorityPoject.fromMapFavorityPoject(Map<String, dynamic> map) {
    return FavorityPoject(
      id: map['id'],
      studentId: StudentUser.fromMapStudentUser(map['studentId']),
      projectId: ProjectCompany.fromMapProjectCompany(map['projectId']),
    );
  }

}