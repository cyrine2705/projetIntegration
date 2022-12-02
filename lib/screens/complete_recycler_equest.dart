import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_integration/services/RecycleRequestManagementService.dart';

import '../helpers/DirectoryHelper.dart';
import '../models/RecycleRequest.dart';
import 'deatil_page_collector.dart';

class CompleteRecycleRequest extends StatefulWidget {
  CompleteRecycleRequest({Key? key}) : super(key: key);

  @override
  State<CompleteRecycleRequest> createState() => _CompleteRecycleRequestState();
}

class _CompleteRecycleRequestState extends State<CompleteRecycleRequest> {
  List<Widget> recycleRequestList = <Widget>[];
  List<RecycleRequest> recycleRequests = <RecycleRequest>[];
  @override
  void initState() {
    super.initState();
    this.fetchValidateRecycleRequests();
  }

  getdata() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 109, 196, 112),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  Container(
                    width: 125.0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[]),
                  )
                ]),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Row(children: [
              const Text(
                "Recycle Requests list ",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            ]),
          ),
          const SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: const EdgeInsets.only(left: 25.0, right: 20.0),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 300.0,
                    child: this.recycleRequestList.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 8, 221, 193)))
                        : ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                color: Colors.black, endIndent: 16, indent: 16),
                            itemCount: this.recycleRequestList.length,
                            itemBuilder: (context, index) =>
                                this.recycleRequestList[index],
                          ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _ProductItem(int id, String imgpath, String name, int quantite,
      String location, String unit, String dateSubmitted, String status) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
          onTap: () {
            Get.to(DetailPage(), arguments: [
              id,
              imgpath,
              name,
              quantite,
              location,
              unit,
              status,
              dateSubmitted
            ]);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(imgpath),
                      fit: BoxFit.fill,
                      height: 50.0,
                      width: 50.0,
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontFamily: 'Montserat',
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$quantite kg",
                          style: const TextStyle(
                            fontFamily: 'Montserat',
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void fetchValidateRecycleRequests() async {
    RecycleRequestManagementService.getAllValidatedRecycleRequests(
            await DirectoryHelper.getToken())
        .then(((response) {
      dynamic responseData = jsonDecode(response.body);

      for (dynamic responseElement in responseData) {
        setState(() {
          recycleRequestList.add(
            _ProductItem(
                responseElement["id"],
                "assets/images/" +
                    responseElement["material"].toString().toLowerCase() +
                    ".png",
                responseElement["material"],
                responseElement["quantity"],
                responseElement["location"],
                responseElement["unit"],
                responseElement["dateSubmitted"],
                responseElement["status"]),
          );

          recycleRequests.add(RecycleRequest.fetchRecycleRequestFromServer(
              responseElement["id"],
              responseElement["material"],
              responseElement["quantity"].toDouble(),
              responseElement["unit"],
              responseElement["location"],
              responseElement["dateSubmitted"],
              responseElement["status"]));
        });
      }
    }));
  }
}
