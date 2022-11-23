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

  String _expression = "";

  final _userInput = TextEditingController(text: "0");
  final _result = TextEditingController();

  void _addNumberInInputField(int num) {
    _expression += num.toString();
    setState(() => _checkIfInputFieldHasValue()
        ? _userInput.text += num.toString()
        : _userInput.text = num.toString());
  }
  void _addOperatorInInputField(String oper) {
    switch(oper){
      case "x" : _expression += "*"; break;
      case "÷" : _expression += "/"; break;
      default: _expression += oper;
    }
    setState(() => _userInput.text += oper);
  }

  bool _checkIfInputFieldHasValue() => _userInput.text.length == 1
      && _userInput.text.startsWith("0") ? false : true;

  void _getResultFromString(){
    var expressionFromInputField = _userInput.text;
    var isLastCharOperator = false;
    for(var v in _listOfOperators.values){
      if(expressionFromInputField.endsWith(v)){
        isLastCharOperator = true;
        break;
      }
    }

    //If operator is the last char, empty result and no calculation
    if(!isLastCharOperator){
      var result =  _expression.interpret();
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
        body: Column(
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
                onPressed: () {
                  if(_checkIfInputFieldHasValue()){
                    _expression = _expression.substring(0, _expression.length - 1);
                    _userInput.text = _userInput.text.substring(0, _userInput.text.length - 1);
                  }
                  if(_userInput.text.isEmpty) {
                    _expression = "";
                    _userInput.text = "0";
                    _result.clear();
                  }
                },
                icon: Icon(
                  Icons.backspace_outlined,
                ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    _userInput.text = "0";
                    _expression = "";
                    _result.clear();
                  }),
                  child: Text("C",),
                ),
                ElevatedButton(
                    onPressed: null,
                    child: Text("( )"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _expression += "/100";
                    setState(() => _userInput.text += "%");
                  },
                  child: Text("%"),
                ),
                OperButton(_listOfOperators['divide']!, _addOperatorInInputField),
              ],
            ),
            Row(
              children: [
                NumberButton(7, _addNumberInInputField),
                NumberButton(8, _addNumberInInputField),
                NumberButton(9, _addNumberInInputField),
                OperButton(_listOfOperators['multiply']!, _addOperatorInInputField),
              ],
            ),
            Row(
              children: [
                NumberButton(4, _addNumberInInputField),
                NumberButton(5, _addNumberInInputField),
                NumberButton(6, _addNumberInInputField),
                OperButton(_listOfOperators['subtract']!, _addOperatorInInputField),
              ],
            ),
            Row(
              children: [
                NumberButton(1, _addNumberInInputField),
                NumberButton(2, _addNumberInInputField),
                NumberButton(3, _addNumberInInputField),
                OperButton(_listOfOperators['add']!, _addOperatorInInputField),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: null,
                  child: Text("+/-"),
                ),
                NumberButton(0, _addNumberInInputField),
                ElevatedButton(
                    onPressed: () => _addOperatorInInputField("."),
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
    );
  }
}