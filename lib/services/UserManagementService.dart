import 'dart:collection';
import 'dart:convert';
import 'package:projet_integration/Hosts.dart';
import 'package:projet_integration/models/Collector.dart';
import '../models/Citizen.dart';
import 'package:http/http.dart' as http;

abstract class UserManagementService {
  static Future<http.Response> citizenSignUp(Citizen citizen) async {
    return await http.post(Uri.parse(Hosts.gatewayUrl + "/signUp"),
        headers: {"Content-type": "application/json"},
        body: json.encode(citizen.getData()));
  }

  static Future<http.Response> collectorSignUp(Citizen citizen) async {
    return await http.post(Uri.parse(Hosts.gatewayUrl + "/collector/signUp"),
        headers: {"Content-type": "application/json"},
        body: json.encode(citizen.getData()));
  }

  static Future<http.Response> login(String username, String password) async {
    return await http.post(Uri.parse(Hosts.gatewayUrl + "/login"),
        headers: {"Content-type": "application/json"},
        body: json.encode({"username": username, "password": password}));
  }

  static dynamic googleLogin() {}

  static dynamic facebookLogin() {}

  static Future<http.Response> logout(String token) async {
    return await http.delete(Uri.parse(Hosts.gatewayUrl + "/logout"),
        headers: {"Content-type": "application/json", "Token": token});
  }

  static dynamic logoutAllSessions(String token) async {
    return await http.delete(Uri.parse(Hosts.gatewayUrl + "/logoutAllSessions"),
        headers: {"Content-type": "application/json", "Token": token});
  }

  static dynamic logoutAllOtherSessions(String token) async {
    return await http.delete(
        Uri.parse(Hosts.gatewayUrl + "/logoutAllOtherSessions"),
        headers: {"Content-type": "application/json", "Token": token});
  }

  static Future<http.Response> confirmAccount(String code) async {
    return await http.patch(Uri.parse(Hosts.gatewayUrl + "/confirmAccount"),
        headers: {"Content-type": "application/json"},
        body: json.encode({"code": code}));
  }

  static void manageTwoFactorAuth() {}

  static dynamic twoFactorAuth(String code) {}
  static dynamic requestPasswordReset(Citizen citizen) {}
  static dynamic resetPassword(String username) {}
  static dynamic changePassword(String token) {}
}
