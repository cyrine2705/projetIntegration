import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_integration/screens/ChoosePage.dart';
import 'package:projet_integration/screens/sign_in_collector.dart';
import 'package:projet_integration/screens/sign_up_collector.dart';

import '../helpers/DirectoryHelper.dart';
import '../screens/signup.dart';
import '../services/UserManagementService.dart';

class CollectorLogout extends StatefulWidget {
  CollectorLogout({Key? key}) : super(key: key);

  @override
  State<CollectorLogout> createState() => _CollectorLogoutState();
}

class _CollectorLogoutState extends State<CollectorLogout> {
  late Map<String, dynamic> userData = Map<String, dynamic>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: logout,
          child: const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "logout",
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: logoutAllSessions,
          child: const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "logoutAllSessions",
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        InkWell(
            onTap: logoutAllOtherSessions,
            child: const Text(
              "logoutAllOtherSessions",
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }

  Future<void> loadUserData() async {
    dynamic data = await DirectoryHelper.getUserData();
    setState(() {
      userData = data;
      print("userdata state $userData");
    });
  }

  logout() async {
    UserManagementService.logout(userData["token"]);
    DirectoryHelper.deleteUserData();
    Get.off(SignInCollector());
  }

  logoutAllSessions() async {
    UserManagementService.logoutAllSessions(userData["token"]);
    DirectoryHelper.deleteUserData();
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpCollector()));
  }

  logoutAllOtherSessions() async {
    UserManagementService.logoutAllOtherSessions(userData["token"])
        .then((response) {
      dynamic responseData = jsonDecode(response.body);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text(responseData["message"]),
              actions: [
                ElevatedButton(
                    onPressed: (() {
                      Get.off(Choose());
                    }),
                    child: Text("OK"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 8, 221, 193))))
              ],
            );
          });
    });
  }
}
