import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCalcPage(title: 'Calculator Application'),
    );
  }
}

class MyCalcPage extends StatefulWidget {
  const MyCalcPage({super.key, required this.title});

  final String title;

  @override
  State<MyCalcPage> createState() => _MyCalcPageState();
}

class _MyCalcPageState extends State<MyCalcPage> {
  String output = '';
  double firstNumber = 0;
  double secondNumber = 0;
  String operator = '';

  void _buttonPressed(String button) {
    if (button == 'Clear') {
      output = '';
      firstNumber = 0;
      secondNumber = 0;
      operator = '';
    } else if (button == '+' || button == '-' || button == '*' || button == '/') {
      firstNumber = double.tryParse(output) ?? 0;
      operator = button;
      output = '';
    } else if (button == '=') {
      secondNumber = double.tryParse(output) ?? 0;
      if (operator == '+') {
        output = (firstNumber + secondNumber).toString();
      } else if (operator == '-') {
        output = (firstNumber - secondNumber).toString();
      } else if (operator == '*') {
        output = (firstNumber * secondNumber).toString();
      } else if (operator == '/') {
        if (secondNumber != 0) {
          output = (firstNumber / secondNumber).toString();
          } else {
            output = 'Error';
          }
      }
      firstNumber = 0;
      secondNumber = 0;
      operator = '';
    } else {
      output += button;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String displayText;
    if (output.isEmpty) {
      displayText = '0';
    } else {
      displayText = output;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            displayText,
            style: TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0'),
              _buildButton('Clear'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 100,
        child: ElevatedButton(
          onPressed: () => _buttonPressed(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(label, style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
