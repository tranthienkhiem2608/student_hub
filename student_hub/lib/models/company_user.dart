import 'package:flutter/material.dart';


class CompanyUser {
  final String fullName;
  final String email;
  final String password;
  final String typeUser = 'company';
  final String companyName;
  final String companyWebsite;
  final String companyDescription;
  final String numberOfEmployees;
  bool isLogin = false;

  CompanyUser({
    required this.fullName,
    required this.email,
    required this.password,
    required this.companyName,
    required this.companyWebsite,
    required this.companyDescription,
    required this.numberOfEmployees,
    required this.isLogin,
  });


 Map<String, dynamic> toMapCompanyUser() {
  return {
    'fullName': fullName,
    'email': email,
    'password': password,
    'typeUser': typeUser,
    'companyName': companyName,
    'companyWebsite': companyWebsite,
    'companyDescription': companyDescription,
    'numberOfEmployees': numberOfEmployees,
  };

}

factory CompanyUser.fromMapCompanyUser(Map<String, dynamic> map) {
  return CompanyUser(
    fullName: map['fullName'],
    email: map['email'],
    password: map['password'],
    companyName: map['companyName'],
    companyWebsite: map['companyWebsite'],
    companyDescription: map['companyDescription'],
    numberOfEmployees: map['numberOfEmployees'],
    isLogin: map['isLogin'],
  );
}

}
// CompanyUser userDemo = CompanyUser(
//   fullName: 'John Doe',
//   email: 'john.doe@example.com',
//   password: 'password123',
//   companyName: 'Doe Enterprises',
//   companyWebsite: 'www.doeenterprises.com',
//   companyDescription: 'We specialize in all things Doe.',
//   numberOfEmployees: '2-9 employees',
// );

List<CompanyUser> accounts = [
  CompanyUser(
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password123',
      companyName: 'Doe Enterprises',
      companyWebsite: 'www.doeenterprises.com',
      companyDescription: 'We specialize in all things Doe.',
      numberOfEmployees: '2-9 employees',
      isLogin: false
  ),
  CompanyUser(
      fullName: 'Jane Dane',
      email: 'jane.doe@example.com',
      password: 'password123',
      companyName: 'Jane Enterprises',
      companyWebsite: 'www.abeerprises.com',
      companyDescription: 'We specialize in all things jane.',
      numberOfEmployees: '2-9 employees',
      isLogin: true
  ),
  CompanyUser(
      fullName: 'Lucy Le',
      email: 'lucy.le@example.com',
      password: 'password123',
      companyName: 'Lucle Enterprises',
      companyWebsite: 'www.lucrprises.com',
      companyDescription: 'We specialize in all things Luc.',
      numberOfEmployees: '10-99 employees',
      isLogin: false
  )

];