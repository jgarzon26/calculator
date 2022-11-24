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

  String _expression = "";

  late String _currentLastNumber;
  bool _hasSignChange = false;
  late int _startIndexOfSignChange;

  bool _isBracketMode = false;

  final _listOfOperators = {
    "add" : "+",
    "subtract" : "-",
    "multiply" : "x",
    "divide" : "÷",
  };

  final _userInput = TextEditingController(text: "0");
  final _result = TextEditingController();

  void _addNumberInInputField(int num) {

    if(_isLastNumberNegative()){
      _addOperatorInInputField("x");
    }

    if(_userInput.text.endsWith("%")){
      _expression += "*";
      _userInput.text += "${_listOfOperators["multiply"]}";
    }
    _expression += num.toString();
    setState(() => _checkIfInputFieldHasValue()
        ? _userInput.text += num.toString()
        : _userInput.text = num.toString());
  }
  void _addOperatorInInputField(String oper) {
    _hasSignChange = false;
    if(!(num.tryParse(_expression.characters.last) != null || _expression.characters.last == ")")){
      _expression = _expression.substring(0, _expression.length - 1);
      _userInput.text = _userInput.text.substring(0, _userInput.text.length - 1);
    }
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

  bool _isLastNumberNegative() => _expression.endsWith(")");

  void _revertToPositive(){
    var startIndex = _expression.lastIndexOf("(", _startIndexOfSignChange);
    _expression = _expression.replaceRange(startIndex, null, _currentLastNumber);
    setState(() {
      _userInput.text = _expression;
      _userInput.text = _userInput.text.replaceAll("*", "x").replaceAll("/", "÷");
    });
    _hasSignChange = false;
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
                  if(_isLastNumberNegative()){
                    _revertToPositive();
                    return;
                  }

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
                    _hasSignChange = false;
                    _isBracketMode = false;
                  }),
                  child: Text("C",),
                ),
                ElevatedButton(
                    onPressed: () {
                      if(num.tryParse(_expression.characters.last) != null){
                        if(!_isBracketMode){
                          _addOperatorInInputField("x");
                        }
                      }
                      else if(num.tryParse(_expression.characters.last) == null && _isBracketMode){
                        return;
                      }
                      _expression += (!_isBracketMode) ? "(" : ")";
                      setState(() => _userInput.text += (!_isBracketMode) ? "(" : ")");
                      _isBracketMode = !_isBracketMode;
                    },
                    child: Text("( )"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _expression += "/100";
                    _expression = _expression.interpret().toString();
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
                  onPressed: () {
                    bool hasFoundLastOperator = false;
                    for(int i = _expression.length - 1; i > -1; i--){
                      for(var v in _listOfOperators.values){
                        if(_userInput.text[i] == v || i == 0){
                          hasFoundLastOperator = true;
                          if(!_hasSignChange){
                            //if there is operators add one, otherwise do nothing
                            var n = (i == 0) ? 0 : 1;
                            _currentLastNumber = _expression.substring(i+n);
                            _expression = _expression.replaceRange(i + n, null, "(-$_currentLastNumber)");
                            setState(() {
                              _userInput.text = _expression;
                              _userInput.text = _userInput.text.replaceAll("*", "x").replaceAll("/", "÷");
                            });
                            _hasSignChange = true;
                            _startIndexOfSignChange = i + n;
                          }else{
                            _revertToPositive();
                          }

                          break;
                        }
                      }
                      if(hasFoundLastOperator) {
                        break;
                      }
                    }
                  },
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