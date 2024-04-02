import 'package:student_hub/models/model/company_user.dart';
import 'package:student_hub/models/model/project_scope.dart';
import 'package:student_hub/models/model/proposal.dart';

class ProjectCompany {
  final int id;
  final CompanyUser companyId;
  final String title;
  final ProjectScope projectScopeId;
  final int numberOfStudent;
  final String description;
  final String? typeFlag;
  final List<String> requiredSkillSet;
  final List<Proposal>? proposals;

  ProjectCompany({
    required this.id,
    required this.companyId,
    required this.title,
    required this.projectScopeId,
    required this.numberOfStudent,
    required this.description,
    this.typeFlag,
    required this.requiredSkillSet,
    this.proposals,
  });

  Map<String, dynamic> toMapProjectCompany() {
    return {
      'id': id,
      'companyId': companyId.toMapCompanyUser(),
      'title': title,
      'projectScopeId': projectScopeId.toMapProjectScope(),
      'numberOfStudent': numberOfStudent,
      'description': description,
      'typeFlag': typeFlag,
      'requiredSkillSet': requiredSkillSet,
      'proposals': proposals?.map((e) => e.toMapProposal()).toList(),
    };
  }

  factory ProjectCompany.fromMapProjectCompany(Map<String, dynamic> map) {
    return ProjectCompany(
      id: map['id'],
      companyId: CompanyUser.fromMapCompanyUser(map['companyId']),
      title: map['title'],
      projectScopeId: ProjectScope.fromMapProjectScope(map['projectScopeId']),
      numberOfStudent: map['numberOfStudent'],
      description: map['description'],
      typeFlag: map['typeFlag'],
      requiredSkillSet: List<String>.from(map['requiredSkillSet']),
      proposals: List<Proposal>.from(
          map['proposals'].map((e) => Proposal.fromMapProposal(e))),
    );
  }
}