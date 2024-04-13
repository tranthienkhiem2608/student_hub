import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/student_user.dart';

class Proposal {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? projectId;
  final int? studentId;
  final String? coverLetter;
  int? statusFlag;
  int? disableFlag;
  final ProjectCompany? projectCompany;
  final StudentUser? studentUser;

  Proposal({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.projectId,
    this.studentId,
    this.coverLetter,
    this.statusFlag,
    this.disableFlag,
    this.projectCompany,
    this.studentUser,
  });

  Map<String, dynamic> toMapProposal() {
    return {
      'id': id,
      'projectId': projectId,
      'studentId': studentId,
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
      'disableFlag': disableFlag,
    };
  }

  factory Proposal.fromMapProposalStudent(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      projectId: map['projectId'],
      studentId: map['studentId'],
      coverLetter: map['coverLetter'],
      statusFlag: map['statusFlag'],
      disableFlag: map['disableFlag'],
      projectCompany:
          ProjectCompany.fromMapProjectCompany(map['projectCompany']),
    );
  }

  factory Proposal.fromMapProposalCompany(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      projectId: map['projectId'],
      studentId: map['studentId'],
      coverLetter: map['coverLetter'],
      statusFlag: map['statusFlag'],
      disableFlag: map['disableFlag'],
    );
  }

  factory Proposal.fromMapProposalStudentUser(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      projectId: map['projectId'],
      studentId: map['studentId'],
      coverLetter: map['coverLetter'],
      statusFlag: map['statusFlag'],
      disableFlag: map['disableFlag'],
      studentUser: StudentUser.fromMapStudentProposal(map['student']),
    );
  }
  static List<Proposal> fromListMapProposalCompany(List<dynamic> list) {
    List<Proposal> proposals = [];
    for (var item in list) {
      proposals.add(Proposal.fromMapProposalCompany(item));
    }
    return proposals;
  }

  static List<Proposal> fromListMapProposalStudent(List<dynamic> list) {
    List<Proposal> proposals = [];
    for (var item in list) {
      proposals.add(Proposal.fromMapProposalStudentUser(item));
    }
    return proposals;
  }
}
