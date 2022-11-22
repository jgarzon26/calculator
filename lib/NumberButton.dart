import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget{

  final int number;
  final void Function(int num) onInput;

  const NumberButton(this.number, this.onInput,{super.key});

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: () => onInput(number),
      child: Text(number.toString()),
    );
  }

}