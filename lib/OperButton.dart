import 'package:flutter/material.dart';
import 'Operations.dart';

class OperButton extends StatelessWidget{

  final Operations operations;

  const OperButton(this.operations, {super.key});

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: null,
      child: Text(
        operations.operator,
      )
    );
  }
}