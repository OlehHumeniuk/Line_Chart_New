import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
enum LineType
{
  isCurved,
  isSplain,
  isLine
}

class LineData
{
  List<FlSpot> data;
  Color lineColor;
  String lineName;
  LineType lineType;

  LineData({
    required this.data,
    required this.lineColor,
    required this.lineName,
    required this.lineType,
  });
}