import 'package:flutter/material.dart';
import 'main_logic.dart';

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
      home: CalculatorLogic(),
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
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CalculatorButton(
                          text: 'C',
                          color: Colors.yellow[200],
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '(',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: ')',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '/',
                          color: Colors.orange,
                          onPressed: onButtonPressed,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CalculatorButton(
                          text: '7',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '8',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '9',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '*',
                          color: Colors.orange,
                          onPressed: onButtonPressed,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CalculatorButton(
                          text: '4',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '5',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '6',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '-',
                          color: Colors.orange,
                          onPressed: onButtonPressed,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CalculatorButton(
                          text: '1',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '2',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '3',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '+',
                          color: Colors.orange,
                          onPressed: onButtonPressed,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CalculatorButton(
                            text: '0',
                            onPressed: onButtonPressed,
                          ),
                        
                        CalculatorButton(
                          text: '.',
                          onPressed: onButtonPressed,
                        ),
                        CalculatorButton(
                          text: '=',
                          color: Colors.green,
                          onPressed: onButtonPressed,
                        ),
                      ],
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
    bool isOrange = widget.color == Colors.orange || widget.color == Colors.green;

    // Use a conditional width for the "0" button
    double buttonWidth = widget.text == '0' ? MediaQuery.of(context).size.width / 3 + 20  : 70;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: buttonWidth,  // Adjust width based on the button text
        height: 70,
        decoration: BoxDecoration(
          color: _isPressed
              ? (widget.color ?? Colors.grey[300])!.withOpacity(0.7)
              : widget.color ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 24,
              color: isOrange ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
} 