import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget{

  final int number;

  const NumberButton(this.number, {super.key});

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: null,
      child: Text(number.toString()),
    );
  }

}