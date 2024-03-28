import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/student_user.dart';

class Proposal{
  final String id;
  final ProjectCompany projectId;
  final StudentUser studentId;
  final String coverLetter;
  final String statusFlag;
  final String disableFlag;

  Proposal({
    required this.id,
    required this.projectId,
    required this.studentId,
    required this.coverLetter,
    required this.statusFlag,
    required this.disableFlag,
  });

  Map<String, dynamic> toMapProposal() {
    return {
      'id': id,
      'projectId': projectId.toMapProjectCompany(),
      'studentId': studentId.toMapStudentUser(),
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
      'disableFlag': disableFlag,
    };
  }

  factory Proposal.fromMapProposal(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      projectId: ProjectCompany.fromMapProjectCompany(map['projectId']),
      studentId: StudentUser.fromMapStudentUser(map['studentId']),
      coverLetter: map['coverLetter'],
      statusFlag: map['statusFlag'],
      disableFlag: map['disableFlag'],
    );
  }
}