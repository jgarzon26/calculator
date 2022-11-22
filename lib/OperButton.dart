import 'package:flutter/material.dart';

class OperButton extends StatelessWidget{

  final String operator;
  final void Function(String oper) onInput;

  const OperButton(this.operator, this.onInput, {super.key});

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: () => onInput(operator),
      child: Text(
        operator,
      )
    );
  }
}