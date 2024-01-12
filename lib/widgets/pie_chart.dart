
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncmed/widgets/bar_chart.dart';

class CalorieMeter extends StatefulWidget {
  CalorieMeter({Key? key}) : super(key: key);

  @override
  State<CalorieMeter> createState() => _CalorieMeterState();
}

class _CalorieMeterState extends State<CalorieMeter> {
  List<int> weeklyCalories = [];
 double data  = Get.arguments;
  var dataMap = <String,double>{
    "Calories": 0,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
     dataMap['Calories'] = data;

    return Scaffold(
        body: Column(
         children: [
          Expanded(
            child: Container(
            color: Theme.of(context).primaryColor,
            height: 200, // Set a height for the chart container
            width:  400, // Set a width for the chart container
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: PieChart(
                dataMap: dataMap,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey[50]!.withOpacity(0.15),
                colorList: colorList,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: false,
                ),
                totalValue: 2500,
              ),
            ),
            ),
          ),
           Expanded(child: LineChartSample3(),)


      ],
    ));
  }
}
