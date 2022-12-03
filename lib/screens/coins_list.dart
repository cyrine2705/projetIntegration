import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);
  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Coins List',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              getWidgets(),
            ])),
        backgroundColor: Color(0xff97D136));
  }
}

class ListData {
  String weight;
  String material;
  String price;
  ListData(
    this.weight,
    this.material,
    this.price,
  );
}

final List<ListData> datalist = [
  ListData("1Kg", "Plastic", "10"),
  ListData("1Kg", "Electronics", "12"),
  ListData("1Kg", "Glass", "15"),
  ListData("1Kg", "Paper", "8"),
  ListData("1Kg", "Metal", "16"),
  ListData("1Kg", "Other", "5"),
];
Widget getWidgets() {
  List<Widget> list = <Widget>[];
  int i = 0;
  while (i < datalist.length) {
    list.add(Container(
      width: Get.width * 0.6,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff6ae792),
            width: 3.0,
          ),
        ),
      ),
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(datalist[i].weight,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold))
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(datalist[i].material,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold))
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(datalist[i].price,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 91, 12)))
            ],
          ),
        ],
      ),
    ));
    i++;
  }
  return Center(
    child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        child: Column(children: list)),
  );
}
