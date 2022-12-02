import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartWidget extends StatefulWidget {
  PieChartWidget({Key? key}) : super(key: key);

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  final dataMap = <String, double>{
    "Plastic": 5,
    "Electronics": 10,
    "Glass": 12,
    "Metal": 18,
    "Paper": 7,
    "Other": 8,
  };
  final legendMap = <String, String>{
    "Plastic": "5",
    "Electronics": "10",
    "Glass": "12",
    "Metal": "18",
    "Paper": "7",
    "Other": "8",
  };

  final colorList = <Color>[
    const Color(0xFF4fb492),
    const Color(0xFFFFDBB0),
    const Color(0xFF69F0AE),
    const Color(0xFFABC2FF),
    const Color(0xFFF6F26F),
    const Color(0xFF3AD0F4),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.8,
      height: Get.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: PieChart(
        dataMap: dataMap,
        chartType: ChartType.ring,
        baseChartColor: Colors.amber.withOpacity(0.15),
        colorList: colorList,
        chartValuesOptions: const ChartValuesOptions(
            showChartValues: true,
            chartValueBackgroundColor: Colors.transparent),
        totalValue: 60,
      ),
    );
  }
}
