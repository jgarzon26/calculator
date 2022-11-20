import 'package:calculator/OperButton.dart';
import 'package:calculator/Operations.dart';
import 'package:flutter/material.dart';
import 'NumberButton.dart';

class Calculator extends StatefulWidget{

  final userInput = TextEditingController();
  final result = TextEditingController();

  Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  void editInputField(int num) => setState(() => widget.userInput.text += num.toString());

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculator",),
        ),
        body: Column(
          children: [
            TextField(
              controller: widget.userInput,
              keyboardType: TextInputType.none,
              textAlign: TextAlign.right,
            ),
            TextField(
              controller: widget.result,
              keyboardType: TextInputType.none,
              textAlign: TextAlign.right,
              enabled: false,
            ),
            Row(
              children: const [
                OperButton(Operations("C")),
                OperButton(Operations("(")),
                OperButton(Operations(")")),
                OperButton(Operations("÷")),
              ],
            ),
            Row(
              children: [
                NumberButton(7, editInputField),
                NumberButton(8, editInputField),
                NumberButton(9, editInputField),
                OperButton(Operations("x")),
              ],
            ),
            Row(
              children: [
                NumberButton(4, editInputField),
                NumberButton(5, editInputField),
                NumberButton(6, editInputField),
                OperButton(Operations("-")),
              ],
            ),
            Row(
              children: [
                NumberButton(1, editInputField),
                NumberButton(2, editInputField),
                NumberButton(3, editInputField),
                OperButton(Operations("+")),
              ],
            ),
            Row(
              children: [
                OperButton(Operations("+/-")),
                NumberButton(0, editInputField),
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