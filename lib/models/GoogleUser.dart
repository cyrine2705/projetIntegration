import 'package:projet_integration/models/User.dart';

class GoogleUser extends User {
  String _username = "";
  String _email = "";

  GoogleUser(String username, String email) {
    this._username = username;
    this._email = email;
  }

  String getUsername() {
    return this._username;
  }

  String getEmail() {
    return this._email;
  }

  void setUsername(String username) {
    this._username = username;
  }

  void setEmail(String email) {
    this._email = email;
  }
}
