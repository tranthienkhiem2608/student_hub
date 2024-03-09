class User{
  final String fullName;
  final String email;
  final String password;
  final String typeUser;

  User({
    required this.fullName,
    required this.email,
    required this.password,
    required this.typeUser,
  });

  Map<String, dynamic> toMapUser() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'typeUser': typeUser,
    };
  }

  factory User.fromMapUser(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      typeUser: map['typeUser'],
    );
  }
}