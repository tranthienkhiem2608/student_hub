import 'package:student_hub/models/not_use/user.dart';

class CompanyUser {
  final User user;
  final String companyName;
  final String companyWebsite;
  final String companyDescription;
  final String numberOfEmployees;
  bool isLogin = false;

  CompanyUser({
    required this.user,
    required this.companyName,
    required this.companyWebsite,
    required this.companyDescription,
    required this.numberOfEmployees,
    required this.isLogin,
  });

  Map<String, dynamic> toMapCompanyUser() {
    return {
      'fullName': user.fullName,
      'email': user.email,
      'password': user.password,
      'typeUser': user.typeUser,
      'companyName': companyName,
      'companyWebsite': companyWebsite,
      'companyDescription': companyDescription,
      'numberOfEmployees': numberOfEmployees,
    };
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
      user: User(
        fullName: 'John Doe',
        email: 'johndone123@gmail.com',
        password: 'password123',
        typeUser: 'company',
      ),
      companyName: 'Doe Enterprises',
      companyWebsite: 'www.doeenterprises.com',
      companyDescription: 'We specialize in all things Doe.',
      numberOfEmployees: '2-9 employees',
      isLogin: false),
  CompanyUser(
      user: User(
        fullName: 'Jane Doe',
        email: 'jane987@gmail.com',
        password: 'password987',
        typeUser: 'company',
      ),
      companyName: 'Jane Enterprises',
      companyWebsite: 'www.abeerprises.com',
      companyDescription: 'We specialize in all things jane.',
      numberOfEmployees: '2-9 employees',
      isLogin: true),
  CompanyUser(
      user: User(
        fullName: 'Lucy Luc',
        email: 'lucy123luc@gmail.com',
        password: 'passwordluc',
        typeUser: 'company',
      ),
      companyName: 'Lucle Enterprises',
      companyWebsite: 'www.lucrprises.com',
      companyDescription: 'We specialize in all things Luc.',
      numberOfEmployees: '10-99 employees',
      isLogin: false)
];
