class User{
  final String email;
  final String password;
  final String? fullname;
  final int? role;

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

  factory User.fromMapUser(Map<String, dynamic> map) {
    // List<int>? roleList;
    // if (map['role'] != null) {
    //   roleList = List<int>.from(map['role']).where((element) => element == 0 || element == 1).toList();
    //   if (roleList.length > 2) {
    //     roleList = roleList.sublist(0, 2);
    //   }
    // }
    return User(
      email: map['email'],
      password: map['password'],
      fullname: map['fullname'],
      role: map['role'],
    );
  }

}