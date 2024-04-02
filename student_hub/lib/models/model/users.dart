class User{
  final int? id;
  final String? email;
  final String? password;
  final String? fullname;
  final List<dynamic>? role;


  User({
    this.id,
    this.email,
    this.password,
    this.fullname,
    this.role,
  });

  Map<String, dynamic> toMapUser()=> {
      'id': id,
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
      id: map['id'],
      email: map['email'],
      password: map['password'],
      fullname: map['fullname'],
      role: map['roles'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullname': fullname,
      'role': role,
    };
  }
}