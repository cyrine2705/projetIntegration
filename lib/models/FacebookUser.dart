import 'package:projet_integration/models/User.dart';

class FacebookUser extends User {
  String _username = "";
  String _profileId = "";

  FacebookUser(String username, String profileId) {
    this._profileId = profileId;
    this._username = username;
  }

  String getUsername() {
    return this._username;
  }

  String getProfileId() {
    return this._profileId;
  }

  void setUsername(String username) {
    this._username = username;
  }

  void setProfileId(String profileId) {
    this._profileId = profileId;
  }
}
