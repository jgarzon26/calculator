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

  void addNumberInInputField(int num) {
    setState(() => _checkIfInputFieldHasValue()
        ? _userInput.text = num.toString()
        : _userInput.text += num.toString());
  }
  void addOperatorInInputField(String oper) {
    setState(() => _userInput.text += oper);
  }

  bool _checkIfInputFieldHasValue() => _userInput.text.length == 1 && _userInput.text.startsWith("0") ? true : false;

  void _getResultFromString(){
    var expression = _userInput.text;
    var matchFound = false;
    for(var v in _listOfOperators.values){
      if(expression.endsWith(v)){
        matchFound = true;
        break;
      }
    }

    if(expression.isNotEmpty && !matchFound){
      expression = expression.replaceAll("x", "*");
      expression = expression.replaceAll("÷", "/");
      var result =  expression.interpret();
      setState(() => _result.text = result.toString());
    }else{
      _result.clear();
    }
  }

  @override
  void initState(){
    super.initState();

    _userInput.addListener(() => _getResultFromString());
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculator",),
        ),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _userInput,
                keyboardType: TextInputType.none,
                textAlign: TextAlign.right,
              ),
              TextField(
                controller: _result,
                keyboardType: TextInputType.none,
                textAlign: TextAlign.right,
                readOnly: true,
              ),
              IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.backspace_outlined,
                  ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _userInput.text = "0";
                      _result.clear();
                    }),
                    child: Text("C",),
                  ),
                  ElevatedButton(
                      onPressed: null,
                      child: Text("( )"),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text("%"),
                  ),
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
                  ElevatedButton(
                    onPressed: null,
                    child: Text("+/-"),
                  ),
                  NumberButton(0, addNumberInInputField),
                  ElevatedButton(
                      onPressed: null,
                      child: Text(".")
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _getResultFromString();
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