import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tested_08_04_graph/Viz_graph/LineType.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/src/chart/line_chart/line_chart_painter.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_extensions.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_painter.dart';
import 'package:fl_chart/src/chart/base/base_chart/base_chart_painter.dart';
import 'package:fl_chart/src/extensions/paint_extension.dart';
import 'package:fl_chart/src/extensions/path_extension.dart';
import 'package:fl_chart/src/extensions/text_align_extension.dart';
import 'package:fl_chart/src/utils/canvas_wrapper.dart';
import 'package:fl_chart/src/utils/utils.dart';
import 'package:flutter/material.dart';

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

class CustomLineTouchData extends LineTouchData
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

typedef GetLineTooltipItems = List<CustomLineTooltipItem?> Function(
  List<LineBarSpot> touchedSpots,
);


class CustomLineTouchTooltipData extends LineTouchTooltipData {
  CustomLineTouchTooltipData({
    double tooltipRoundedRadius = 4,
    EdgeInsets tooltipPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    double tooltipMargin = 16,
    FLHorizontalAlignment tooltipHorizontalAlignment = FLHorizontalAlignment.center,
    double tooltipHorizontalOffset = 0,
    double maxContentWidth = 120,
    required GetLineTooltipItems getCustomTooltipItems, // rename the parameter
    GetLineTooltipColor getTooltipColor = defaultLineTooltipColor,
    bool fitInsideHorizontally = false,
    bool fitInsideVertically = false,
    bool showOnTopOfTheChartBoxArea = false,
    double rotateAngle = 0.0,
    BorderSide tooltipBorder = BorderSide.none,
  }) : super(
            tooltipRoundedRadius: tooltipRoundedRadius,
            tooltipPadding: tooltipPadding,
            tooltipMargin: tooltipMargin,
            tooltipHorizontalAlignment: tooltipHorizontalAlignment,
            tooltipHorizontalOffset: tooltipHorizontalOffset,
            maxContentWidth: maxContentWidth,
            getTooltipItems: getCustomTooltipItems, // pass the renamed parameter here
            getTooltipColor: getTooltipColor,
            fitInsideHorizontally: fitInsideHorizontally,
            fitInsideVertically: fitInsideVertically,
            showOnTopOfTheChartBoxArea: showOnTopOfTheChartBoxArea,
            rotateAngle: rotateAngle,
            tooltipBorder: tooltipBorder,
          );
}

  

// Outside of your CustomLineTouchTooltipData class, define the function that will create your custom tooltip items.
List<LineTooltipItem?> getCustomTooltipItems(List<LineData> linesData, List<LineBarSpot> touchedSpots) {  
  // Assuming you have access to linesData here, you need to pass it into this scope.
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

class CustomLineChartPainter extends LineChartPainter
{
  CustomLineChartPainter() : super() {
    _barPaint = Paint()..style = PaintingStyle.stroke;

    _barAreaPaint = Paint()..style = PaintingStyle.fill;

    _barAreaLinesPaint = Paint()..style = PaintingStyle.stroke;

    _clearBarAreaPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0x00000000)
      ..blendMode = BlendMode.dstIn;

    _touchLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    _bgTouchTooltipPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    _borderTouchTooltipPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.transparent
      ..strokeWidth = 1.0;
  }
  late Paint _barPaint;
  late Paint _barAreaPaint;
  late Paint _barAreaLinesPaint;
  late Paint _clearBarAreaPaint;
  late Paint _touchLinePaint;
  late Paint _bgTouchTooltipPaint;
  late Paint _borderTouchTooltipPaint;

  @override
  void drawTouchTooltip(
    BuildContext context,
    CanvasWrapper canvasWrapper,
    CustomLineTouchTooltipData tooltipData,
    FlSpot showOnSpot,
    ShowingTooltipIndicators showingTooltipSpots,
    PaintHolder<LineChartData> holder,
  ) {
    final viewSize = canvasWrapper.size;

    const textsBelowMargin = 4;

    /// creating TextPainters to calculate the width and height of the tooltip
    final drawingTextPainters = <TextPainter>[];

    final tooltipItems =
        tooltipData.getTooltipItems(showingTooltipSpots.showingSpots);
    if (tooltipItems.length != showingTooltipSpots.showingSpots.length) {
      throw Exception('tooltipItems and touchedSpots size should be same');
    }

    for (var i = 0; i < showingTooltipSpots.showingSpots.length; i++) {
      final tooltipItem = tooltipItems[i];
      if (tooltipItem == null) {
        continue;
      }
      final richText = RichText(
        text:tooltipItem.richText,
      );
      // final span = TextSpan(
      //   style: Utils().getThemeAwareTextStyle(context, tooltipItem.textStyle),
      //   text: tooltipItem.text,
      //   children: tooltipItem.children,
      // );

      final tp = TextPainter(
        text: richText,
        textAlign: tooltipItem.textAlign,
        textDirection: tooltipItem.textDirection,
        textScaler: holder.textScaler,
      )..layout(maxWidth: tooltipData.maxContentWidth);
      drawingTextPainters.add(tp);
    }
    if (drawingTextPainters.isEmpty) {
      return;
    }

    /// biggerWidth
    /// some texts maybe larger, then we should
    /// draw the tooltip' width as wide as biggerWidth
    ///
    /// sumTextsHeight
    /// sum up all Texts height, then we should
    /// draw the tooltip's height as tall as sumTextsHeight
    var biggerWidth = 0.0;
    var sumTextsHeight = 0.0;
    for (final tp in drawingTextPainters) {
      if (tp.width > biggerWidth) {
        biggerWidth = tp.width;
      }
      sumTextsHeight += tp.height;
    }
    sumTextsHeight += (drawingTextPainters.length - 1) * textsBelowMargin;

    /// if we have multiple bar lines,
    /// there are more than one FlCandidate on touch area,
    /// we should get the most top FlSpot Offset to draw the tooltip on top of it
    final mostTopOffset = Offset(
      getPixelX(showOnSpot.x, viewSize, holder),
      getPixelY(showOnSpot.y, viewSize, holder),
    );

    final tooltipWidth = biggerWidth + tooltipData.tooltipPadding.horizontal;
    final tooltipHeight = sumTextsHeight + tooltipData.tooltipPadding.vertical;

    double tooltipTopPosition;
    if (tooltipData.showOnTopOfTheChartBoxArea) {
      tooltipTopPosition = 0 - tooltipHeight - tooltipData.tooltipMargin;
    } else {
      tooltipTopPosition =
          mostTopOffset.dy - tooltipHeight - tooltipData.tooltipMargin;
    }

    final tooltipLeftPosition = getTooltipLeft(
      mostTopOffset.dx,
      tooltipWidth,
      tooltipData.tooltipHorizontalAlignment,
      tooltipData.tooltipHorizontalOffset,
    );

    /// draw the background rect with rounded radius
    var rect = Rect.fromLTWH(
      tooltipLeftPosition,
      tooltipTopPosition,
      tooltipWidth,
      tooltipHeight,
    );

    if (tooltipData.fitInsideHorizontally) {
      if (rect.left < 0) {
        final shiftAmount = 0 - rect.left;
        rect = Rect.fromLTRB(
          rect.left + shiftAmount,
          rect.top,
          rect.right + shiftAmount,
          rect.bottom,
        );
      }

      if (rect.right > viewSize.width) {
        final shiftAmount = rect.right - viewSize.width;
        rect = Rect.fromLTRB(
          rect.left - shiftAmount,
          rect.top,
          rect.right - shiftAmount,
          rect.bottom,
        );
      }
    }

    if (tooltipData.fitInsideVertically) {
      if (rect.top < 0) {
        final shiftAmount = 0 - rect.top;
        rect = Rect.fromLTRB(
          rect.left,
          rect.top + shiftAmount,
          rect.right,
          rect.bottom + shiftAmount,
        );
      }

      if (rect.bottom > viewSize.height) {
        final shiftAmount = rect.bottom - viewSize.height;
        rect = Rect.fromLTRB(
          rect.left,
          rect.top - shiftAmount,
          rect.right,
          rect.bottom - shiftAmount,
        );
      }
    }

    final radius = Radius.circular(tooltipData.tooltipRoundedRadius);
    final roundedRect = RRect.fromRectAndCorners(
      rect,
      topLeft: radius,
      topRight: radius,
      bottomLeft: radius,
      bottomRight: radius,
    );

    var topSpot = showingTooltipSpots.showingSpots[0];
    for (final barSpot in showingTooltipSpots.showingSpots) {
      if (barSpot.y > topSpot.y) {
        topSpot = barSpot;
      }
    }

    _bgTouchTooltipPaint.color = tooltipData.getTooltipColor(topSpot);

    final rotateAngle = tooltipData.rotateAngle;
    final rectRotationOffset =
        Offset(0, Utils().calculateRotationOffset(rect.size, rotateAngle).dy);
    final rectDrawOffset = Offset(roundedRect.left, roundedRect.top);

    final textRotationOffset =
        Utils().calculateRotationOffset(rect.size, rotateAngle);

    if (tooltipData.tooltipBorder != BorderSide.none) {
      _borderTouchTooltipPaint
        ..color = tooltipData.tooltipBorder.color
        ..strokeWidth = tooltipData.tooltipBorder.width;
    }

    canvasWrapper.drawRotated(
      size: rect.size,
      rotationOffset: rectRotationOffset,
      drawOffset: rectDrawOffset,
      angle: rotateAngle,
      drawCallback: () {
        canvasWrapper
          ..drawRRect(roundedRect, _bgTouchTooltipPaint)
          ..drawRRect(roundedRect, _borderTouchTooltipPaint);
      },
    );

    /// draw the texts one by one in below of each other
    var topPosSeek = tooltipData.tooltipPadding.top;
    for (final tp in drawingTextPainters) {
      final yOffset = rect.topCenter.dy +
          topPosSeek -
          textRotationOffset.dy +
          rectRotationOffset.dy;

      final align = tp.textAlign.getFinalHorizontalAlignment(tp.textDirection);
      final xOffset = switch (align) {
        HorizontalAlignment.left => rect.left + tooltipData.tooltipPadding.left,
        HorizontalAlignment.right =>
          rect.right - tooltipData.tooltipPadding.right - tp.width,
        _ => rect.center.dx - (tp.width / 2),
      };

      final drawOffset = Offset(
        xOffset,
        yOffset,
      );

      canvasWrapper.drawRotated(
        size: rect.size,
        rotationOffset: rectRotationOffset,
        drawOffset: rectDrawOffset,
        angle: rotateAngle,
        drawCallback: () {
          canvasWrapper.drawText(tp, drawOffset);
        },
      );
      topPosSeek += tp.height;
      topPosSeek += textsBelowMargin;
    }
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


  CustomLineTouchTooltipData getCustomLineTouchTooltipData(List<LineChartBarData> lineBarsData) {

    CustomLineTouchTooltipData customLineTouchTooltipData = CustomLineTouchTooltipData(
      getCustomTooltipItems: (List<LineBarSpot> touchedSpots) {  
        // Assuming you have access to linesData here, you need to pass it into this scope.
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
      },
    );

    return customLineTouchTooltipData;
  }
  LineTouchData lineTouchData(List<LineChartBarData> lineBarsData) {
    LineTouchData lineTouchData = LineTouchData(
      touchTooltipData: getCustomLineTouchTooltipData(lineBarsData),
      touchSpotThreshold: 10, // Відстань чутливості до точки
      enabled: true,
    );

    return lineTouchData;
  }

  // LineTouchData lineTouchData2(List<LineChartBarData> lineBarsData) {
  //   LineTouchData lineTouchData = LineTouchData(
  //     touchTooltipData: LineTouchTooltipData(
  //       getTooltipItems: (List<LineBarSpot> touchedBarSpots) 
  //       {
  //         // Повернення тултіпу ВСІХ точок
  //         List<LineTooltipItem> lLineTooltipItem = [];
  //         for(int i =0; i < lineBarsData.length; i++)
  //         {
  //           Color lineBarDataColor = linesData[i].lineColor;
  //           String lineName = linesData[i].lineName;
  //           for(var lineBarSpot in lineBarsData[i].spots)
  //           {
  //             for (var barSpot in touchedBarSpots) 
  //             {
  //               if(lineBarSpot.x == barSpot.x && lineBarSpot.y == barSpot.y)
  //               {
  //                 lLineTooltipItem.add(
  //                   LineTooltipItem(
  //                     '${lineName}: ${barSpot.y}',
  //                     TextStyle(color:  lineBarDataColor)),
  //                 );
  //               }
  //             }
  //           }
  //         }
  //         return lLineTooltipItem;
  //       },
  //     ),
  //     touchSpotThreshold: 10, // Відстань чутливості до точки
  //     enabled: true,
  //   );

  //   return lineTouchData;
  // }
  

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
