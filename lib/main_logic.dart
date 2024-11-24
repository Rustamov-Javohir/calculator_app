import 'package:flutter/material.dart';
import 'main.dart'; // Import the UI file

class CalculatorLogic extends StatefulWidget {
  @override
  _CalculatorLogicState createState() => _CalculatorLogicState();
}

class _CalculatorLogicState extends State<CalculatorLogic> {
  void _onButtonPressed(String buttonText) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorUI(
      displayText: "0",
      onButtonPressed: _onButtonPressed,
    );
  }
}
