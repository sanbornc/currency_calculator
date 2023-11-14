import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;

  const CalculatorButton(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed(text);
      },
      
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        padding: const EdgeInsets.all(10.0),
        fixedSize: const Size(100, 100)
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 36.0, color: Colors.black),
      ),
    );
  }
}