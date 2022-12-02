import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_integration/screens/home.dart';
import 'package:projet_integration/screens/home_collector.dart';
import 'package:projet_integration/screens/sign_up_collector.dart';
import 'package:projet_integration/screens/signup.dart';

import '../helpers/DirectoryHelper.dart';
import '../services/UserManagementService.dart';
import 'ConfirmationCode.dart';

class SignInCollector extends StatefulWidget {
  SignInCollector({Key? key}) : super(key: key);

  @override
  State<SignInCollector> createState() => _SignInCollectorState();
}

class _SignInCollectorState extends State<SignInCollector> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _validate = false;
  bool _validatep = false;
  bool _validateu = false;
  bool _validatepa = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 4, 4, 4),
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 100),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'User Name',
                              errorText: _validate
                                  ? 'Value Cant Be Empty'
                                  : _validateu
                                      ? 'incorect username'
                                      : null,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              errorText: _validate
                                  ? 'Value Cant Be Empty'
                                  : _validateu
                                      ? 'incorect username'
                                      : null,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.green,
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                      login();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Get.to(SignUpCollector());
                                  });
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void login() {
    UserManagementService.login(
            this.nameController.text, this.passwordController.text)
        .then((response) async {
      dynamic responseData = jsonDecode(response.body);
      if (responseData["message"] == "password is wrong" ||
          responseData["message"] == "user not found" ||
          responseData["message"] ==
              "your account is temporarily blocked please try again later!") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(responseData["message"]),
                actions: [
                  ElevatedButton(
                      onPressed: Navigator.of(context).pop,
                      child: Text("OK"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 8, 221, 193))))
                ],
              );
            });
      }

      if (responseData["message"] ==
          "A confirmation code has been sent to your email")
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ConfirmationCodePage()));
      else {
        DirectoryHelper.setUserData(responseData);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeCollector()));
      }
    });
  }
}
