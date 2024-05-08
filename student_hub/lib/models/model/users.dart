import 'package:student_hub/models/model/company_user.dart';
import 'package:student_hub/models/model/student_user.dart';

class User {
  int? id;
  String? email;
  String? password;
  String? fullname;
  List<dynamic>? role;
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
  Map<String, dynamic> toMapUserLogin() => {
        'email': email,
        'password': password,
      };

  factory User.fromMapUser(Map<String, dynamic> map) => User(
        id: map['id'],
        // email: map['email'],
        // password: map['password'],
        fullname: map['fullname'],
        role: map['roles'],
        studentUser: map['student'] == null
            ? null
            : StudentUser.fromMapStudentUser(map['student']),
        companyUser: map['company'] == null
            ? null
            : CompanyUser.fromMapCompanyUser(map['company']),
      );

  factory User.fromMapUserForCompany(Map<String, dynamic> map) => User(
        companyUser: CompanyUser.fromMapCompanyUser(map['result']),
      );

  factory User.fromMapUserChat(Map<String, dynamic> map) => User(
        id: map['id'],
        fullname: map['fullname'],
      );
  factory User.fromMapUserNotification(Map<String, dynamic> map) => User(
        id: map['id'],
        fullname: map['fullname'],
        email: map['email'],
      );
}
