import 'package:currency_calculator/common/conversion.dart';
import 'package:flutter/material.dart';

class CurrencyRow extends StatelessWidget {
  final Conversion conversion;
  final Function(CurrencyRow source) onCurrencyPressed;

  const CurrencyRow(this.conversion, this.onCurrencyPressed,  {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            onCurrencyPressed(this);
          },
          child: Text( 
            conversion.currency!.flag ?? "",
            style: const TextStyle(fontSize: 48.0), 
          ),
        ),
        Expanded( 
          child: Text(
            conversion.displayText, //AsFixed(conversion.currency?.decimalDigits ?? 0),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 48.0, 
              color: conversion.isBase ? Colors.black : Colors.grey
              ),
          ),
        )
      ],

    );
  }
}