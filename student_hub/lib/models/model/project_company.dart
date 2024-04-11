import 'package:student_hub/models/model/company_user.dart';
import 'package:student_hub/models/model/project_scope.dart';
import 'package:student_hub/models/model/proposal.dart';

class ProjectCompany {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? companyId;
  String? title;
  int? projectScopeFlag;
  int? numberOfStudent;
  String? description;
  int? typeFlag;
  int? countProposal;

  ProjectCompany({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.title,
    this.projectScopeFlag,
    this.numberOfStudent,
    this.description,
    this.typeFlag,
    this.countProposal,
  });

  Map<String, dynamic> toMapProjectCompany() {
    return {
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'description': description,
      'typeFlag': typeFlag,
      'numberOfStudents': numberOfStudent,
    };
  }

  factory ProjectCompany.fromMapProjectCompany(Map<String, dynamic> map) {
    return ProjectCompany(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      companyId: map['companyId'],
      projectScopeFlag: map['projectScopeId'],
      title: map['title'],
      description: map['description'],
      numberOfStudent: map['numberOfStudent'],
      typeFlag: map['typeFlag'],
      countProposal: map['countProposal'],
    );
  }
}
