import 'package:flutter/material.dart';
import 'NumberButton.dart';

class Calculator extends StatelessWidget{
  
  const Calculator({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                NumberButton(7),
                NumberButton(8),
                NumberButton(9),
              ],
            ),
            Row(
              children: [
                NumberButton(4),
                NumberButton(5),
                NumberButton(6),
              ],
            ),
            Row(
              children: [
                NumberButton(1),
                NumberButton(2),
                NumberButton(3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}