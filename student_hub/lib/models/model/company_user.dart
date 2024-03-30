import 'package:student_hub/models/model/users.dart';

class CompanyUser{
  final String id;
  final User user;
  final String? companyName;
  final int? size;
  final String? website;
  final String? description;


  CompanyUser({
    required this.id,
    required this.user,
     this.companyName,
      this.size,
     this.website,
     this.description,
  });

Map<String, dynamic> toMapCompanyUser() => {
      'id': id,
      'userId': user.toMapUser(),
      'companyName': companyName,
      'size': size,
      'website': website,
      'description': description,

  };

  factory CompanyUser.fromMapCompanyUser(Map<String, dynamic> map) {
    return CompanyUser(
      id: map['id'],
      user: User.fromMapUser(map['user']),
      companyName: map['companyName'],
      size: map['size'],
      website: map['website'],
      description: map['description'],
    );
  }

  toMapCompany() {}
}