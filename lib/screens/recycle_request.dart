import 'dart:convert';

import '../helpers/DirectoryHelper.dart';
import '../models/RecycleRequest.dart';
import '../services/RecycleRequestManagementService.dart';
import 'package:flutter/material.dart';

class CitizenRecycleRequestPage extends StatefulWidget {
  const CitizenRecycleRequestPage({super.key});

  @override
  State<CitizenRecycleRequestPage> createState() =>
      _CitizenRecycleRequestPageState();
}

class _CitizenRecycleRequestPageState extends State<CitizenRecycleRequestPage> {
  List<ListTile> recycleRequestList = <ListTile>[];
  List<RecycleRequest> recycleRequests = <RecycleRequest>[];

  late Widget empty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchRecycleRequestsMade();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 50),
        child: this.recycleRequestList.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 8, 221, 193)))
            : ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.black, endIndent: 16, indent: 16),
                itemCount: this.recycleRequestList.length,
                itemBuilder: (context, index) => this.recycleRequestList[index],
              ));
  }

  void fetchRecycleRequestsMade() async {
    RecycleRequestManagementService.getRecycleRequestsMade(
            await DirectoryHelper.getToken())
        .then(((response) {
      dynamic responseData = jsonDecode(response.body);

      for (dynamic responseElement in responseData) {
        setState(() {
          recycleRequestList.add(
            ListTile(
                leading: Text(
                    "${responseElement["material"]} ${responseElement["quantity"]}${responseElement["unit"]}"),
                trailing: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff4ABB47))),
                    child: Text("details"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                                title: Text("Recycle Request Details",
                                    textAlign: TextAlign.center),
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          Text(
                                            "Request id: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("${responseElement["id"]}")
                                        ]),
                                        Row(children: [
                                          Text(
                                            "Material type: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("${responseElement["material"]}")
                                        ]),
                                        Row(children: [
                                          Text(
                                            "Quantity: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "${responseElement["quantity"]} ${responseElement["unit"]}")
                                        ]),
                                        Row(children: [
                                          Text(
                                            "Location: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                              child: Text(
                                                  "${responseElement["location"]}"))
                                        ]),
                                        Row(children: [
                                          Text(
                                            "Date submitted: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "${responseElement["dateSubmitted"]}")
                                        ]),
                                        Row(children: [
                                          Text(
                                            "Request status: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("${responseElement["status"]}")
                                        ]),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 60),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () =>
                                                  withdrawRecycleRequest(
                                                      responseElement["id"],
                                                      responseData.indexOf(
                                                          responseElement)),
                                              child: Text("Withdraw"),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color.fromARGB(255,
                                                              187, 31, 20)))),
                                          Text("       "),
                                          ElevatedButton(
                                              onPressed:
                                                  Navigator.of(context).pop,
                                              child: Text("Ok"),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color(0xff4ABB47))))
                                        ],
                                      ))
                                ]);
                          });
                    })),
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

  void withdrawRecycleRequest(int recycleRequestId, int index) async {
    RecycleRequestManagementService.withdrawRecycleRequest(
            recycleRequestId, await DirectoryHelper.getToken())
        .then((response) {
      Navigator.of(context).pop();
      dynamic responseData = jsonDecode(response.body);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Success"),
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

      setState(() {
        this.recycleRequestList.removeAt(index);
        this.recycleRequests.removeAt(index);
      });
    });
  }
}
