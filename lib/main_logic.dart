import 'package:flutter/material.dart';
import 'main.dart'; // Import the UI file

class CalculatorLogic extends StatefulWidget {
  @override
  _CalculatorLogicState createState() => _CalculatorLogicState();
}

class _CalculatorLogicState extends State<CalculatorLogic> {
  String _displayText = "0";
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = "";
  bool _isSecondOperand = false;
  
  void _onButtonPressed(String buttonText) {
  setState(() {
    if (buttonText == "C") {
      // Reset calculator
      _displayText = "0";
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = "";
      _isSecondOperand = false;
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      // Handle operator input
      _firstOperand = double.tryParse(_displayText) ?? 0;
      _operator = buttonText;
      _isSecondOperand = true;
      _displayText = "0";
    } else if (buttonText == "=") {
      // Perform calculation
      _secondOperand = double.tryParse(_displayText) ?? 0;

      double result;
      switch (_operator) {
        case "+":
          result = _firstOperand + _secondOperand;
          break;
        case "-":
          result = _firstOperand - _secondOperand;
          break;
        case "*":
          result = _firstOperand * _secondOperand;
          break;
        case "/":
          result = _secondOperand != 0 ? _firstOperand / _secondOperand : double.nan;
          break;
        default:
          result = 0;
      }
      _displayText = result.toStringAsFixed(12).replaceAll(RegExp(r"\.?0+$"), "");
      _operator = "";
      _isSecondOperand = false;
    } else {
      // Handle number and decimal point input
      if (buttonText == ".") {
        if (!_displayText.contains(".")) {
          _displayText += buttonText;
        }
      } else {
        if (_displayText == "0" || _isSecondOperand) {
          _displayText = buttonText;
          _isSecondOperand = false;
        } else {
          _displayText += buttonText;
        }
      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return CalculatorUI(
      displayText: _displayText,
      onButtonPressed: _onButtonPressed,
    );
  }
}
