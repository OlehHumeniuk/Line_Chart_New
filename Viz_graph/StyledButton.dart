import 'package:flutter/material.dart';


class StyledButton extends StatelessWidget {
  final TextStyle textStyle;
  final Color buttonColor;
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  StyledButton({
    this.textStyle = const TextStyle(
      color: Colors.white, // колір тексту
      fontWeight: FontWeight.bold, // жирний текст
      fontSize: 16, // розмір шрифту
    ),
    required this.buttonColor,
    required this.text,
    required this.onPressed,
    this.width = 50.0,
    this.height = 50.0,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: MaterialButton(
        onPressed: onPressed,
        color: buttonColor,
        height: height,
        minWidth: width,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}