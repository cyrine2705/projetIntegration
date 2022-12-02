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
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 8, 221, 193))),
                    child: Text("details"),
                    onPressed: () {
                      
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

 
}
