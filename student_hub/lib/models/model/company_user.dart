import 'package:student_hub/models/model/users.dart';

class CompanyUser{
  final String id;
  final String? companyName;
  final int? size;
  final String? website;
  final String? description;


  CompanyUser({
    required this.id,
     this.companyName,
      this.size,
     this.website,
     this.description,
  });

Map<String, dynamic> toMapCompanyUser() => {
      'id': id,
      'companyName': companyName,
      'size': size,
      'website': website,
      'description': description,

  };

  factory CompanyUser.fromMapCompanyUser(Map<String, dynamic> map) {
    return CompanyUser(
      id: map['id'],
      companyName: map['companyName'],
      size: map['size'],
      website: map['website'],
      description: map['description'],
    );
  }

  toMapCompany() {}
}