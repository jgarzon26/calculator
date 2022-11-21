import 'dart:developer';

import 'package:calculator/OperButton.dart';
import 'package:flutter/material.dart';
import 'NumberButton.dart';
import 'package:function_tree/function_tree.dart';

class Calculator extends StatefulWidget{

  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  final _listOfOperators = {
    "add" : "+",
    "subtract" : "-",
    "multiply" : "x",
    "divide" : "÷",
  };

  final _userInput = TextEditingController(text: "0");
  final _result = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void addNumberInInputField(int num) {
    setState(() => _userInput.text += num.toString());
  }
  void addOperatorInInputField(String oper) {
    setState(() => _userInput.text += oper);
  }

  num getResultFromString(String expression){
    expression = expression.replaceAll("x", "*");
    expression = expression.replaceAll("÷", "/");
    return expression.interpret();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculator",),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _userInput,
                keyboardType: TextInputType.none,
                textAlign: TextAlign.right,
                validator: (value) {
                  if(value != null){
                    for(var v in _listOfOperators.values){
                      if(value.endsWith(v)){
                        return "null";
                      }
                    }
                  }
                  return null;
                },
              ),
              TextField(
                controller: _result,
                keyboardType: TextInputType.none,
                textAlign: TextAlign.right,
                readOnly: true,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _userInput.clear();
                      _result.clear();
                    }),
                    child: Text("C",),
                  ),
                  //OperButton(Operations("(")),
                  //OperButton(Operations(")")),
                  OperButton(_listOfOperators['divide']!, addOperatorInInputField),
                ],
              ),
              Row(
                children: [
                  NumberButton(7, addNumberInInputField),
                  NumberButton(8, addNumberInInputField),
                  NumberButton(9, addNumberInInputField),
                  OperButton(_listOfOperators['multiply']!, addOperatorInInputField),
                ],
              ),
              Row(
                children: [
                  NumberButton(4, addNumberInInputField),
                  NumberButton(5, addNumberInInputField),
                  NumberButton(6, addNumberInInputField),
                  OperButton(_listOfOperators['subtract']!, addOperatorInInputField),
                ],
              ),
              Row(
                children: [
                  NumberButton(1, addNumberInInputField),
                  NumberButton(2, addNumberInInputField),
                  NumberButton(3, addNumberInInputField),
                  OperButton(_listOfOperators['add']!, addOperatorInInputField),
                ],
              ),
              Row(
                children: [
                  //OperButton(Operations("+/-")),
                  NumberButton(0, addNumberInInputField),
                  //OperButton(Operations(".")),
                  ElevatedButton(
                    onPressed: () {
                      var expression = _userInput.text;
                      if(_formKey.currentState!.validate()){
                        var result = getResultFromString(expression);
                        setState(() => _result.text = result.toString());
                      }
                    },
                    child: Text("=",),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}