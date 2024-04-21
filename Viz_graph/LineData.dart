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

class ChartPage extends StatefulWidget {
  // Дані для графіку, можуть бути динамічно змінені або отримані з зовнішнього джерела
  final List<LineData> linesData;
  // final List<FlSpot> chartData;
  ChartPage({
    // required this.chartData,
    required this.linesData,
  });
  
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Chart Widget'),
      ),
      body: Center(
        child: CustomChart(linesData: widget.linesData),
      ),
    );
  }
}


class CustomChart extends StatelessWidget {
  final List<LineData> linesData;

  const CustomChart({Key? key, required this.linesData}) : super(key: key);



  FlTitlesData getTitlesData()
  {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      // bottomTitles: AxisTitles(
      //   sideTitles: SideTitles(
      //     showTitles: true,
      //     reservedSize: 35,
      //     getTitlesWidget: bottomTitleWidgets,
      //   ),
      // ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  LineChartData getLineChartData(List<LineChartBarData> lineBarsData, {Color? color,double? minY,double? maxY})
  {
    return LineChartData(
        lineBarsData: lineBarsData,
        minY: minY, // Мінімальне значення по осі Y
        maxY: maxY, // Максимальне значення по осі Y (встановіть відповідно до ваших даних)
        titlesData: getTitlesData(),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.green, width: 1),
        ),
        lineTouchData: LineTouchData(enabled: false),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: 1.5,
              color: Colors.green.withOpacity(0.3),
              strokeWidth: 4,
              dashArray: [5, 5],
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // Генерація LineChartBarData для кожної лінії
    List<LineChartBarData> lineBarsData = linesData
        .map((lineData) => LineChartBarData(
              spots: lineData.data,
              isCurved: true,
              color: lineData.lineColor,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ))
        .toList();

    return LineChart(
      getLineChartData(lineBarsData, color: Colors.green, minY: 0, maxY: 10),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('2011', style: style);
        break;
      case 1:
        text = const Text('2012', style: style);
        break;
      case 2:
        text = const Text('2013', style: style);
        break;
      // додайте більше міток для інших значень
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }
}
