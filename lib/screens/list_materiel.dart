import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/retry.dart';

import 'package:number_selection/number_selection.dart';

import 'package:get/get.dart';
import 'package:projet_integration/screens/position.dart';
import 'package:projet_integration/services/RecycleRequestManagementService.dart';

import '../helpers/DateHelper.dart';
import '../helpers/DirectoryHelper.dart';
import '../models/RecycleRequest.dart';
import 'custom_shape.dart';

class ListMaterial extends StatefulWidget {
  const ListMaterial({Key? key}) : super(key: key);

  @override
  _ListMaterialState createState() => _ListMaterialState();
}

class _ListMaterialState extends State<ListMaterial> {
  String? type;
  bool isLoading = false;
  int _currentValue = 1;
  final TextEditingController unitController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

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
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff4ABB47), Color(0xff97D136)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ))),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: GridView.builder(
                  itemCount: gridlist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          gridlist[index].selected = true;
                        });
                        Get.defaultDialog(
                          title: "Make a recycle request",
                          backgroundColor: Colors.white,
                          titleStyle: const TextStyle(
                            color: Color(0xff97D136),
                          ),
                          middleTextStyle: const TextStyle(
                            color: Color(0xff97D136),
                          ),
                          textConfirm: "Confirm",
                          textCancel: "Cancel",
                          cancelTextColor: Color(0xff97D136),
                          confirmTextColor: Colors.white,
                          buttonColor: Color(0xff4ABB47),
                          onConfirm: () {
                            setState(() {
                              _getCurrentPosition();

                              type = gridlist[index].title!;
                              submit();
                              Get.back();
                              gridlist[index].selected = false;
                            });
                          },
                          onCancel: () {
                            setState(() {
                              gridlist[index].selected = false;
                            });
                          },
                          barrierDismissible: false,
                          radius: 50,
                          content: SizedBox(
                            width: 220,
                            height: 200,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Expanded(
                                    child: TextField(
                                      maxLines: null,
                                      expands: true,
                                      decoration: InputDecoration(
                                        labelText: "Describe the material",
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("Quantity (kg) :  "),
                                      SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: NumberSelection(
                                            theme: NumberSelectionTheme(
                                              draggableCircleColor:
                                                  Color(0xff97D136),
                                              iconsColor: Colors.white,
                                              numberColor: Colors.white,
                                              backgroundColor:
                                                  Color(0xff4ABB47),
                                            ),
                                            initialValue: 1,
                                            minValue: 1,
                                            maxValue: 100,
                                            direction: Axis.horizontal,
                                            withSpring: true,
                                            onChanged: (int value) =>
                                                _currentValue = value,
                                            enableOnOutOfConstraintsAnimation:
                                                true,
                                          )),
                                    ],
                                  ),
                                ]),
                          ),
                        );
                      },
                      child: Card(
                        color: gridlist[index].selected
                            ? Color.fromARGB(255, 129, 243, 125)
                            : Colors.white,
                        elevation: 10,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: SizedBox(
                                      height: 150.0,
                                      width: 100.0,
                                      child: gridlist[index].image)),
                              SizedBox(
                                  height: 30,
                                  child: Text(
                                    gridlist[index].title.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
    );
  }

  void submit() async {
    setState(() {
      isLoading = true;
    });

    RecycleRequestManagementService.makeRecycleRequest(
            RecycleRequest.createRecycleRequest(
                type.toString(),
                double.parse(_currentValue.toString()),
                "kg",
                _currentAddress.toString(),
                DateHelper.generateCurrentDate(),
                "Pending"),
            await DirectoryHelper.getToken())
        .then((response) {
      dynamic responseData = jsonDecode(response.body);
      setState(() {
        isLoading = false;
      });
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
    });

    reset();
  }

  void reset() {
    setState(() {
      type = "";
      _currentAddress = "";
      _currentValue = 1;
    });
  }

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() => _currentPosition = position);
      print(" $position");
      await _getAddressFromLatLng(_currentPosition!);
      submit();
    }).catchError((e) {
      print(e);
    });
  }

  Future<String?> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

        print("$_currentAddress");
      });
      return _currentAddress.toString();
    }).catchError((e) {
      debugPrint(e);
      return e;
    });
  }
}

class GridData {
  String? title;
  Widget? image;
  bool selected;
  GridData(
    this.title,
    this.image,
    this.selected,
  );
}

final List<GridData> gridlist = [
  GridData(
      "Plastic", Image(image: AssetImage('assets/images/bottle1.png')), false),
  GridData("Electronics", Image(image: AssetImage('assets/images/apple1.png')),
      false),
  GridData(
      "Glass", Image(image: AssetImage('assets/images/glass1.png')), false),
  GridData(
      "Metal", Image(image: AssetImage('assets/images/metal1.png')), false),
  GridData(
      "Paper", Image(image: AssetImage('assets/images/paper1.png')), false),
  GridData(
      "Other", Image(image: AssetImage('assets/images/other1.png')), false),
];
