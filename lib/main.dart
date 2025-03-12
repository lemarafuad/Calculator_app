import 'package:flutter/material.dart';

void main() {
  runApp(const MyCalculator());
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  static const List<String> calculatorButtons = [
    "C", ":)", ":)", "÷",
    "7", "8", "9", "×",
    "4", "5", "6", "+",
    "1", "2", "3", "-",
    ":)", "0", ".", "=",
  ];

  String inputText = "";
  String inputData = "";
  String outputText = "";
  String operation = "";
  double num1 = 0.0;
  double num2 = 0.0;
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("MyCalculator")),
        body: Column(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              height: 270,
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      inputText,
                      style:
                      TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      outputText,
                      style:
                      TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              height: 550,
              width: double.infinity,
              color: Colors.grey,
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: calculatorButtons.length,
                itemBuilder: (context, index) {
                  String button = calculatorButtons[index];
                  return ElevatedButton(
                    onPressed: button == ":)" ? null : () {
                      _onButtonPressed(button);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: isOperator(button) || button == "C" ? Colors.teal : Colors.white,
                      foregroundColor: isOperator(button) || button == "C" ? Colors.white : Colors.teal,
                    ),
                    child: Text(
                      button,
                      style: TextStyle(fontSize: 35),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isOperator(String button) {
    return button == "+" ||
        button == "-" ||
        button == "×" ||
        button == "÷" ||
        button == "=";
  }

  void _onButtonPressed(String button) {
    setState(() {
      if (button == "C") {
        inputText = "";
        inputData = "";
        outputText = "";
        operation = "";
        num1 = 0.0;
        num2 = 0.0;
        result = 0.0;
      } else if (button == ".") {
        if (!inputData.contains(".")) {
          inputText += button;
          inputData += button;
        }
      } else if (isOperator(button)) {
        if (button == "=") {
          if (inputData.isNotEmpty && operation.isNotEmpty) {
            num2 = double.parse(inputData);
            switch (operation) {
              case "+":
                result = num1 + num2;
                break;
              case "-":
                result = num1 - num2;
                break;
              case "×":
                result = num1 * num2;
                break;
              case "÷":
                result = num2 != 0 ? (num1 / num2) : 0 ;
                break;
            }
            outputText = result % 1 == 0 ? result.toStringAsFixed(0) : result.toString();
            inputData = outputText;
            operation = "";
          }
        }
        else if (inputText.isNotEmpty) {
          num1 = double.parse(inputData);
          operation = button;
          inputData = "";
          inputText += button;
        }
        else if (outputText.isNotEmpty && inputData.isEmpty) {
          num1 = double.parse(outputText);
        }

      }
      else
      {
        if (outputText.isNotEmpty && inputText.isNotEmpty&& operation.isEmpty) {
          inputText = "";
          outputText = "";
          inputData = "";
          inputText += button;
          inputData += button;
        }
        else{
          inputText += button;
          inputData += button;
        }

      }
    });
  }
}
