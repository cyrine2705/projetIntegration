import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_integration/screens/home_collector.dart';

import '../helpers/DirectoryHelper.dart';
import '../services/RecycleRequestManagementService.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int id = Get.arguments[0];
  var imgpath = Get.arguments[1];
  var name = Get.arguments[2];
  var quantite = Get.arguments[3];
  var location = Get.arguments[4];
  var unit = Get.arguments[5];
  var status = Get.arguments[6];
  var dateSubmitted = Get.arguments[7];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 109, 196, 112),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            setState(() {
              Get.off(HomeCollector());
            });
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Liste des demandes',
          style: TextStyle(
              fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
            color: Colors.white,
          )
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                top: 75.0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: 30.0,
                left: (MediaQuery.of(context).size.width / 3),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgpath),
                      fit: BoxFit.fill,
                    ),
                  ),
                  height: 130.0,
                  width: 130.0,
                ),
              ),
              Positioned(
                  top: 200.0,
                  left: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.blueAccent,
                              ),
                            ),
                            TextSpan(text: location),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Text.rich(TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.production_quantity_limits,
                              color: Colors.blueAccent,
                            ),
                          ),
                          TextSpan(text: "$quantite  $unit"),
                        ],
                      )),
                      const SizedBox(height: 25.0),
                      Text.rich(TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.car_crash,
                              color: Colors.blueAccent,
                            ),
                          ),
                          TextSpan(text: status),
                        ],
                      )),
                      const SizedBox(height: 25.0),
                      Text.rich(TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.date_range_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),
                          TextSpan(
                            text: dateSubmitted,
                            style: TextStyle(),
                          ),
                        ],
                      )),
                    ],
                  )),
              Positioned(
                  top: 400.0,
                  left: (MediaQuery.of(context).size.width / 6),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 109, 196, 112)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)))),
                        onPressed: () {
                          validateRecycleRequest(id);
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  void validateRecycleRequest(int recycleRequestId) async {
    RecycleRequestManagementService.validateRecycleRequest(
            recycleRequestId, await DirectoryHelper.getToken())
        .then((response) {
      dynamic responseData = jsonDecode(response.body);
      print(responseData);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text(responseData["message"]),
              actions: [
                ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        Get.off(HomeCollector());
                      });
                    }),
                    child: Text("OK"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 109, 196, 112))))
              ],
            );
          });
    });
  }
}
