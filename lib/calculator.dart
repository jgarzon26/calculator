import 'dart:developer';

import 'package:calculator/OperButton.dart';
import 'package:flutter/material.dart';
import 'NumberButton.dart';
import 'package:function_tree/function_tree.dart';

class Calculator extends StatefulWidget{

  final userInput = TextEditingController();
  final result = TextEditingController();

  Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  void addNumberInInputField(int num) {
    setState(() => widget.userInput.text += num.toString());
  }
  void addOperatorInInputField(String oper) {
    setState(() => widget.userInput.text += oper);
  }

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
              readOnly: true,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    widget.userInput.clear();
                    widget.result.clear();
                  }),
                  child: Text("C",),
                ),
                //OperButton(Operations("(")),
                //OperButton(Operations(")")),
                OperButton("÷", addOperatorInInputField),
              ],
            ),
            Row(
              children: [
                NumberButton(7, addNumberInInputField),
                NumberButton(8, addNumberInInputField),
                NumberButton(9, addNumberInInputField),
                OperButton("x", addOperatorInInputField),
              ],
            ),
            Row(
              children: [
                NumberButton(4, addNumberInInputField),
                NumberButton(5, addNumberInInputField),
                NumberButton(6, addNumberInInputField),
                OperButton("-", addOperatorInInputField),
              ],
            ),
            Row(
              children: [
                NumberButton(1, addNumberInInputField),
                NumberButton(2, addNumberInInputField),
                NumberButton(3, addNumberInInputField),
                OperButton("+", addOperatorInInputField),
              ],
            ),
            Row(
              children: [
                //OperButton(Operations("+/-")),
                NumberButton(0, addNumberInInputField),
                //OperButton(Operations(".")),
                ElevatedButton(
                  onPressed: () {
                    var expression = widget.userInput.text;
                    expression = expression.replaceAll("x", "*");
                    expression = expression.replaceAll("÷", "/");
                    log(expression.toString());
                    var result = expression.interpret();
                    setState(() => widget.result.text = result.toString());
                  },
                  child: Text("=",),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}