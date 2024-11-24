import 'package:flutter/material.dart';
import 'main_logic.dart'; // Import the logic file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorLogic(), // Use CalculatorLogic as the root widget
    );
  }
}

class CalculatorUI extends StatelessWidget {
  final String displayText;
  final Function(String) onButtonPressed;

  const CalculatorUI({
    Key? key,
    required this.displayText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            // Display Section
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    displayText,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
            // Buttons Section
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  children: [
                    ...['C', '(', ')', '/'].map(
                      (text) => CalculatorButton(
                        text: text,
                        color: text == 'C' ? Colors.yellow[200] : Colors.orange,
                        onPressed: onButtonPressed,
                      ),
                    ),
                    ...['7', '8', '9', 'x'].map(
                      (text) => CalculatorButton(
                        text: text,
                        color: text == 'x' ? Colors.orange : Colors.grey[300],
                        onPressed: onButtonPressed,
                      ),
                    ),
                    ...['4', '5', '6', '-'].map(
                      (text) => CalculatorButton(
                        text: text,
                        color: text == '-' ? Colors.orange : Colors.grey[300],
                        onPressed: onButtonPressed,
                      ),
                    ),
                    ...['1', '2', '3', '+'].map(
                      (text) => CalculatorButton(
                        text: text,
                        color: text == '+' ? Colors.orange : Colors.grey[300],
                        onPressed: onButtonPressed,
                      ),
                    ),
                    ...['0', '.', '='].map(
                      (text) => CalculatorButton(
                        text: text,
                        color: text == '=' ? Colors.green : Colors.grey[300],
                        onPressed: onButtonPressed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatefulWidget {
  final String text;
  final Color? color;
  final Function(String) onPressed;

  const CalculatorButton({
    Key? key,
    required this.text,
    this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CalculatorButtonState createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    widget.onPressed(widget.text);
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _isPressed
              ? (widget.color ?? Colors.grey[300])!.withOpacity(0.7)
              : widget.color ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isPressed
              ? []
              : const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
