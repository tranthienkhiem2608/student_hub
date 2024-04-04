import 'package:student_hub/models/model/company_user.dart';
import 'package:student_hub/models/model/student_user.dart';

class User {
  final int? id;
  final String? email;
  final String? password;
  final String? fullname;
  final List<dynamic>? role;
  StudentUser? studentUser;
  CompanyUser? companyUser;

  User({
    this.id,
    this.email,
    this.password,
    this.fullname,
    this.role,
    this.studentUser,
    this.companyUser,
  });

  Map<String, dynamic> toMapUser() => {
        'id': id,
        'email': email,
        'password': password,
        'fullname': fullname,
        'role': role?.last,
        'student': studentUser?.toMapStudentUser(),
        'company': companyUser?.toMapCompanyUser(),
      };

  factory User.fromMapUser(Map<String, dynamic> map) => User(
      // List<int>? roleList;
      // if (map['role'] != null) {
      //   roleList = List<int>.from(map['role']).where((element) => element == 0 || element == 1).toList();
      //   if (roleList.length > 2) {
      //     roleList = roleList.sublist(0, 2);
      //   }
      // }
      id: map['id'],
      email: map['email'],
      password: map['password'],
      fullname: map['fullname'],
      role: map['roles'],
      studentUser: map['student'] == null
          ? null
          : StudentUser.fromMapStudentUser(map['student']),
      companyUser: map['company'] == null
          ? null
          : CompanyUser.fromMapCompanyUser(map['company']));
}
