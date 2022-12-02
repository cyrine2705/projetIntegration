import 'package:projet_integration/models/User.dart';

class GenericUser extends User {
  String _username = "";
  String _email = "";
  String _password = "";

  GenericUser(String username, String email, String password) {
    this._username = username;
    this._email = email;
    this._password = password;
  }

  String getUsername() {
    return this._username;
  }

  String getEmail() {
    return this._email;
  }

  String getPassword() {
    return this._password;
  }

  void setUsername(String username) {
    this._username = username;
  }

  void setEmail(String email) {
    this._email = email;
  }

  void setPassword(String password) {
    this._password = password;
  }

  getData() {
    return {
      "username": this._username,
      "email": this._email,
      "password": this._password
    };
  }
}
