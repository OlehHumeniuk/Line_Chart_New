import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:tested_08_04_graph/Viz_graph/LineType.dart';
import 'package:tested_08_04_graph/Viz_graph/ChartPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<LineData> linesData = [
    LineData(
      data: [
        FlSpot(0, 1),
        FlSpot(1, 3),
        FlSpot(2, 2),
        FlSpot(3, 4),
        FlSpot(4, 3),
      ],
      lineColor: Colors.blue,
      lineName: 'Line 1',
      lineType: LineType.isLine,
    ),
    LineData(
      data: [
        FlSpot(0, 2),
        FlSpot(1, 4),
        FlSpot(2, 3),
        FlSpot(3, 5),
        FlSpot(4, 4),
      ],
      lineColor: Colors.red,
      lineName: 'Line 2',
      lineType: LineType.isLine,
    ),
    LineData(
      data: [
        FlSpot(0, 3),
        FlSpot(1, 5),
        FlSpot(2, 4),
        FlSpot(3, 6),
        FlSpot(4, 5),
      ],
      lineColor: Colors.brown,
      lineName: 'Line 3',
      lineType: LineType.isLine,
    ),
    LineData(
      data: [
        FlSpot(0, 4),
        FlSpot(1, 6),
        FlSpot(2, 5),
        FlSpot(3, 7),
        FlSpot(4, 6),
      ],
      lineColor: Colors.orange,
      lineName: 'Line 4',
      lineType: LineType.isLine,
    ),
  ];
    return MaterialApp(
      title: 'Custom Chart Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChartPage(linesData: linesData),
    );
  }
}