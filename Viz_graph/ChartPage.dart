import 'package:flutter/material.dart';

import 'package:tested_08_04_graph/Viz_graph/LineType.dart';
import 'package:tested_08_04_graph/Viz_graph/StyledButton.dart';
import 'package:tested_08_04_graph/Viz_graph/CustomChart.dart';


class ChartPage extends StatefulWidget {
  // Дані для графіку, можуть бути динамічно змінені або отримані з зовнішнього джерела
  final List<LineData> linesData;
  final List<String> dataButtons;

  ChartPage({required this.linesData, List<String>? dataButtons})
      : this.dataButtons = dataButtons ?? ["1d", "3d", "1w", "1m", "3m", "6m", "1y"];
  
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  TextStyle dataButtonsStyle()
  {
    return const TextStyle(
      color: Colors.white, // колір тексту
      fontWeight: FontWeight.bold, // жирний текст
      fontSize: 16, // розмір шрифту
    );
  }

  Row topRow()
  {
    return Row(
      children: widget.dataButtons.map((buttonText) {
        return StyledButton(
          text: buttonText,
          textStyle: dataButtonsStyle(),
          buttonColor: const Color(0xFF6F6F6F),
          onPressed: () {
            // Ваша функція, яка буде виконуватися при натисканні
            // Можливо, вам також потрібно передати інформацію про натискання, наприклад, `buttonText`
          },
          width: 75,
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Chart Widget'),
      ),
      body: Column(
        children :
        [
          topRow(), 
          CustomChart(linesData: widget.linesData),
        ]
      ),
    );
  }
}
