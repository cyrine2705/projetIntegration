import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_integration/screens/ChoosePage.dart';
import 'package:projet_integration/screens/signin.dart';
import 'package:projet_integration/screens/signup.dart';

import '../helpers/DirectoryHelper.dart';
import '../services/UserManagementService.dart';

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key});

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget>
    with TickerProviderStateMixin {
  bool isTapped = true;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FoldableOptions(),
    );
  }
}

class FoldableOptions extends StatefulWidget {
  @override
  _FoldableOptionsState createState() => _FoldableOptionsState();
}

class _FoldableOptionsState extends State<FoldableOptions>
    with SingleTickerProviderStateMixin {
  final List<IconData> options = [
    Icons.logout,
    Icons.logout_outlined,
    Icons.login_rounded,
  ];

  late Animation<Alignment> firstAnim;
  late Animation<Alignment> secondAnim;
  late Animation<Alignment> thirdAnim;

  late Animation<double> verticalPadding;
  late AnimationController controller;
  final duration = Duration(milliseconds: 190);
  late Map<String, dynamic> userData = Map<String, dynamic>();

  Widget getItem(IconData source, dynamic functionName) {
    final size = 45.0;
    return GestureDetector(
      onTap: () {
        controller.reverse();
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Color(0xff4ABB47),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: IconButton(
          icon: Icon(source, color: Colors.white.withOpacity(1.0), size: 20),
          onPressed: functionName,
        ),
      ),
    );
  }

  Widget buildPrimaryItem(IconData source) {
    final size = 45.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xff4ABB47),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0xff4ABB47).withOpacity(0.8),
              blurRadius: verticalPadding.value),
        ],
      ),
      child: Icon(
        source,
        color: Colors.white.withOpacity(1),
        size: 20,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
    controller = AnimationController(vsync: this, duration: duration);

    final anim = CurvedAnimation(parent: controller, curve: Curves.linear);
    firstAnim =
        Tween<Alignment>(begin: Alignment.centerRight, end: Alignment.topRight)
            .animate(anim);
    secondAnim = Tween<Alignment>(
            begin: Alignment.centerRight, end: Alignment.centerLeft)
        .animate(anim);
    thirdAnim = Tween<Alignment>(
            begin: Alignment.centerRight, end: Alignment.bottomRight)
        .animate(anim);

    verticalPadding = Tween<double>(begin: 0, end: 5).animate(anim);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 210,
      margin: EdgeInsets.only(right: 15),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: firstAnim.value,
                child: getItem(options.elementAt(0), logout),
              ),
              Align(
                alignment: secondAnim.value,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 37, top: verticalPadding.value),
                  child: getItem(options.elementAt(1), logoutAllSessions),
                ),
              ),
              Align(
                alignment: thirdAnim.value,
                child: getItem(options.elementAt(2), logoutAllOtherSessions),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    controller.isCompleted
                        ? controller.reverse()
                        : controller.forward();
                  },
                  child: buildPrimaryItem(
                    controller.isCompleted || controller.isAnimating
                        ? Icons.close
                        : Icons.add,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> loadUserData() async {
    dynamic data = await DirectoryHelper.getUserData();
    setState(() {
      userData = data;
      print("hedhy userdata state $userData");
    });
  }

  logout() async {
    UserManagementService.logout(userData["token"]);
    DirectoryHelper.deleteUserData();
    Get.off(SignIn());
  }

  logoutAllSessions() async {
    UserManagementService.logoutAllSessions(userData["token"]);
    DirectoryHelper.deleteUserData();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
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
