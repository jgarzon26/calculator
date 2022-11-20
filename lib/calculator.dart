import 'package:calculator/OperButton.dart';
import 'package:calculator/Operations.dart';
import 'package:flutter/material.dart';
import 'NumberButton.dart';

class Calculator extends StatefulWidget{

  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculator",),
        ),
        body: Column(
          children: [
            Row(
              children: const [
                OperButton(Operations("C")),
                OperButton(Operations("(")),
                OperButton(Operations(")")),
                OperButton(Operations("÷")),
              ],
            ),
            Row(
              children: const [
                NumberButton(7),
                NumberButton(8),
                NumberButton(9),
                OperButton(Operations("x")),
              ],
            ),
            Row(
              children: const [
                NumberButton(4),
                NumberButton(5),
                NumberButton(6),
                OperButton(Operations("-")),
              ],
            ),
            Row(
              children: const [
                NumberButton(1),
                NumberButton(2),
                NumberButton(3),
                OperButton(Operations("+")),
              ],
            ),
            Row(
              children: const [
                OperButton(Operations("+/-")),
                NumberButton(0),
                OperButton(Operations(".")),
                OperButton(Operations("=")),
              ],
            )
          ],
        ),
      ),
    );
  }
}