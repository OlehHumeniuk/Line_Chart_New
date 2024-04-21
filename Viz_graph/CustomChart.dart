import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tested_08_04_graph/Viz_graph/LineType.dart';
import 'package:equatable/equatable.dart';

  // Define your custom LineTooltipItem subclass, if needed
  class CustomLineTooltipItem extends LineTooltipItem {
    final RichText richText;
    CustomLineTooltipItem(this.richText) : super('', TextStyle());

    // If you need to use properties from the EquatableMixin in your custom class,
    // you should override the props getter.
    @override
    List<Object?> get props => [richText, ...super.props];
  }
  
  List<LineTooltipItem?> getCustomLineTooltipItems(
    List<LineData> linesData,
    List<LineBarSpot> touchedSpots,
  ) {
    List<LineTooltipItem?> customLineTooltipItemList = [];

    for (int i = 0; i < touchedSpots.length; i++) {
      final richText = RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '${linesData[i].lineName}: ',
              style: TextStyle(color: linesData[i].lineColor),
            ),
            TextSpan(
              text: '${touchedSpots[i].y}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
      customLineTooltipItemList.add(CustomLineTooltipItem(richText));
    }

    return customLineTooltipItemList;
  }

class CustomLineTouchData extends LineTouchTooltipData
{
  @override
  List<LineTooltipItem> defaultLineTooltipItem(List<LineData> linesData, List<LineBarSpot> touchedSpots) {
    List<LineTooltipItem> customLineTooltipItemList = [];

    for (int i = 0; i < touchedSpots.length; i++) {
      final richText = RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '${linesData[i].lineName}: ',
              style: TextStyle(color: linesData[i].lineColor),
            ),
            TextSpan(
              text: '${touchedSpots[i].y}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
      customLineTooltipItemList.add(CustomLineTooltipItem(richText));
    }

    return customLineTooltipItemList;
  }

}

class CustomChart extends StatelessWidget {
  final List<LineData> linesData;

  CustomChart({Key? key, required this.linesData}) : super(key: key);

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


  LineTouchData lineTouchData(List<LineChartBarData> lineBarsData) {
    LineTouchData lineTouchData = LineTouchData(
      touchTooltipData: LineTouchTooltipData(
      getTooltipItems: (List<LineBarSpot> touchedBarSpots) 
        {
          // Повернення тултіпу ВСІХ точок
          List<LineTooltipItem?> lLineTooltipItem = getCustomLineTooltipItems(linesData, touchedBarSpots);
          return lLineTooltipItem;
        },
      ),
      touchSpotThreshold: 10, // Відстань чутливості до точки
      enabled: true,
    );

    return lineTouchData;
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
      lineTouchData: lineTouchData(lineBarsData),
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
    
    return Container(
      width: MediaQuery.of(context).size.width, // ширина на ширину екрану
      height: MediaQuery.of(context).size.height / 2, // висота на половину висоти екрану
      child: LineChart(
        getLineChartData(lineBarsData, color: Colors.green, minY: 0, maxY: 10),
      ),
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
