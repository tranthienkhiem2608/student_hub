import 'package:bcrypt/bcrypt.dart';
String encryptPassword(String password) {
  String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
  return hashedPassword;
}