class User{
  final String email;
  final String password;
  final String? fullname;
  final String? role;

  User({
    required this.email,
    required this.password,
    this.fullname,
    this.role,
  });

  Map<String, dynamic> toMapUser()=> {
      'email': email,
      'password': password,
      'fullname': fullname,
      'role': role,
  };

  factory User.fromMapUser(Map<String, dynamic> map) => User(
      email: map['email'],
      password: map['password'],
      fullname: map['fullname'],
      role: map['role'],
    );

}