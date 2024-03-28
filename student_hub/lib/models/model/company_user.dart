import 'package:student_hub/models/model/users.dart';

class CompanyUser{
  final String id;
  final User userId;
  final String? companyName;
  final String? website;
  final String? description;


  CompanyUser({
    required this.id,
    required this.userId,
     this.companyName,
     this.website,
     this.description,
  });

Map<String, dynamic> toMapCompanyUser() {
    return {
      'id': id,
      'userId': userId.toMapUser(),
      'companyName': companyName,
      'website': website,
      'description': description,
    };
  }

  factory CompanyUser.fromMapCompanyUser(Map<String, dynamic> map) {
    return CompanyUser(
      id: map['id'],
      userId: User.fromMapUser(map['userId']),
      companyName: map['companyName'],
      website: map['website'],
      description: map['description'],
    );
  }
}