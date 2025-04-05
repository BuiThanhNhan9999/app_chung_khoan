import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";
  String result = "";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "=") {
        try {
          String sanitizedExpression = expression.replaceAll('x', '*').replaceAll(':', '/');
          Parser p = Parser();
          Expression exp = p.parse(sanitizedExpression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();
        } catch (e) {
          result = "Lỗi";
        }
      } else if (value == "C") {
        expression = "";
        result = "";
      } else {
        expression += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Máy tính")),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(expression, style: TextStyle(fontSize: 32)),
                  SizedBox(height: 10),
                  Text(result, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                button("7"), button("8"), button("9"), button("/"),
                button("4"), button("5"), button("6"), button("x"),
                button("1"), button("2"), button("3"), button("-"),
                button("C"), button("0"), button("="), button("+"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget button(String value) {
    return GestureDetector(
      onTap: () => onButtonPressed(value),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
