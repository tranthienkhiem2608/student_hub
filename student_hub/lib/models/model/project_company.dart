import 'package:student_hub/models/model/company_user.dart';
import 'package:student_hub/models/model/project_scope.dart';
import 'package:student_hub/models/model/proposal.dart';

class ProjectCompany {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? companyId;
  int? projectScopeFlag;
  String? title;
  String? description;
  int? numberOfStudents;
  int? typeFlag;
  List<Proposal>? proposals;
  int? countProposal;
  int? countMessages;
  int? countHired;
  bool isFavorite;

  ProjectCompany({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.projectScopeFlag,
    this.title,
    this.description,
    this.numberOfStudents,
    this.typeFlag,
    this.proposals,
    this.countProposal,
    this.countMessages,
    this.countHired,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMapProjectCompany() {
    return {
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'description': description,
      'typeFlag': typeFlag,
      'numberOfStudents': numberOfStudents,
    };
  }

  factory ProjectCompany.fromMapProjectCompany(Map<String, dynamic> map) {
    return ProjectCompany(
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      companyId: map['companyId'],
      projectScopeFlag: map['projectScopeFlag'],
      title: map['title'],
      description: map['description'],
      numberOfStudents: map['numberOfStudents'],
      typeFlag: map['typeFlag'],
      proposals: Proposal.fromListMapProposalCompany(map['proposals']),
      countProposal: map['countProposals'],
      countMessages: map['countMessages'],
      countHired: map['countHired'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  static List<ProjectCompany> fromListMapProjectCompany(List<dynamic> list) {
    List<ProjectCompany> projects = [];
    for (var project in list) {
      projects.add(ProjectCompany.fromMapProjectCompany(project));
    }
    return projects;
  }

  factory ProjectCompany.fromMapAllProject(Map<String, dynamic> map) {
    return ProjectCompany(
      id: map['projectId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      companyId: map['companyId'],
      projectScopeFlag: map['projectScopeFlag'],
      title: map['title'],
      description: map['description'],
      numberOfStudents: map['numberOfStudents'],
      typeFlag: map['typeFlag'],
      countProposal: map['countProposals'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  static List<ProjectCompany> fromListMapAllProject(List<dynamic> list) {
    List<ProjectCompany> projects = [];
    for (var project in list) {
      projects.add(ProjectCompany.fromMapAllProject(project));
    }
    return projects;
  }
}
