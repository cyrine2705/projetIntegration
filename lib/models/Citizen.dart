import 'package:projet_integration/models/User.dart';

class Citizen {
  User _userProfile = new User();
  String _name = "";
  String _lastname = "";
  int _recycleCoins = 0;

  Citizen(
      User _userProfile, String _name, String _lastname, int _recycleCoins) {
    this._userProfile = _userProfile;
    this._name = _name;
    this._lastname = _lastname;
    this._recycleCoins = _recycleCoins;
  }

  User getUserProfile() {
    return this._userProfile;
  }

  String getName() {
    return this._name;
  }

  String getLastname() {
    return this._lastname;
  }

  int getRecycleCoins() {
    return this._recycleCoins;
  }

  void setUserProfile(User userProfile) {
    this._userProfile = userProfile;
  }

  void setName(String name) {
    this._name = name;
  }

  void setLastname(String lastname) {
    this._lastname = lastname;
  }

  void setRecycleCoins(int recycleCoins) {
    this._recycleCoins = recycleCoins;
  }

  dynamic getData() {
    return {
      "user_profile": this._userProfile.getData(),
      "name": this._name,
      "lastname": this._lastname,
      "recycleCoins": this._recycleCoins
    };
  }
}
