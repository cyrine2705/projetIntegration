import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_integration/screens/home_collector.dart';
import 'package:projet_integration/screens/sign_in_collector.dart';
import 'package:projet_integration/screens/sign_up_collector.dart';
import 'package:projet_integration/widgets/animated_button.dart';

import 'custom_shape.dart';
import 'signin.dart';

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff4ABB47), Color(0xff97D136)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ))),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.07),
            const Text("Are you a ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            RipplesAnimation(
                fun: () {
                  setState(() {
                    Get.to(SignIn());
                  });
                },
                text: "Citizen"),
            const SizedBox(
              height: 15,
            ),
            const Text("or ",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            RipplesAnimation(
                fun: () {
                  setState(() {
                    Get.to(SignInCollector());
                  });
                },
                text: "Collector"),
          ],
        ),
      ),
    );
  }
}
