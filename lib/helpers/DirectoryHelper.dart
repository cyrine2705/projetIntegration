import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class DirectoryHelper {
  static Future<String> getBaseDir() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  }

  static appendUserData(Map<String, dynamic> data) async {
    String appDir = await DirectoryHelper.getBaseDir();
    File("${appDir}/localStorage.json").writeAsString(data.toString());
  }

  static Future<Map<String, dynamic>> getUserData() async {
    String appDir = await DirectoryHelper.getBaseDir();
    dynamic userData =
        jsonDecode(File("${appDir}/localStorage.json").readAsStringSync());
    print("userdata $userData");
    return userData;
  }

  static Future<String> getToken() async {
    String appDir = await DirectoryHelper.getBaseDir();
    dynamic userData =
        jsonDecode(File("${appDir}/localStorage.json").readAsStringSync());
    return userData["token"];
  }

  static void deleteUserData() async {
    String appDir = await DirectoryHelper.getBaseDir();
    File("${appDir}/localStorage.json").writeAsString("{}");
  }

  static void setUserData(dynamic response) async {
    Directory appDir = await getApplicationDocumentsDirectory();
    File("${appDir.path}/localStorage.json")
        .writeAsString(jsonEncode(response));
  }
}
