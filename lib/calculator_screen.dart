import 'package:currency_calculator/calculator_button.dart';
import 'package:currency_calculator/common/conversion.dart';
import 'package:currency_calculator/common/currency.dart';
import 'package:currency_calculator/currency_repo.dart';
import 'package:currency_calculator/currency_row.dart';
import 'package:currency_calculator/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  Conversion baseConversion = Conversion.getBase();
  Conversion targetConversion = Conversion.getTarget();
  List<Currency> currencies = [];

  @override void initState() {
    // TODO: implement initState
    refresh();
    super.initState();
  }

  void refresh() {
    setState(() {
      CurrencyRepo.fetchCurrencies().then((value) => {
        setState(() {
          currencies = value;
        })
      });
    });
  }

  void handleButtonPress(String text) {
    if (text == '←') {
      // Backspace
      setState(() {
        baseConversion.backSpace();
      });
    } else if (text == 'C') {
      // Clear the input
      setState(() {
        baseConversion.clear();
      });
    } else if (text == '🔃') {
      setState(() {
        Conversion temp = baseConversion;
        baseConversion = targetConversion;
        targetConversion = temp;

        baseConversion.isBase = true;
        targetConversion.isBase = false;
      });
    } else if (text == '.') {
      // Append a decimal point to the current input
      setState(() {
        baseConversion.addDecimal();
      });
    } else {
      // Append the button's text to the current input
      setState(() {
        baseConversion.appendDigit(int.parse(text));
      });
    }

    setState(() {
      calculate();
    });
  }

  void calculate() {
    setState(() {
      targetConversion.calculateAmount(baseConversion);
    });
  }

  void handleCurrencyPressed(CurrencyRow source) {
    setState(() {
      _showCurrencyDialog(source);
    });
  }

  void _showCurrencyDialog(CurrencyRow source) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context)  => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 0.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CurrencySelector(
            currencies,
            (Currency currency) {
              setState(() {
                source.conversion.currency = currency;
              });
              calculate();
              //Navigator.pop(context);
            },
            source.conversion.currency!,
            
          )
        ),
      ),
    );
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Calculator'),
        actions: [
          IconButton(
            onPressed: () => refresh(),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CurrencyRow(baseConversion, handleCurrencyPressed),
            CurrencyRow(targetConversion, handleCurrencyPressed),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton('C', handleButtonPress),
                CalculatorButton('🔃', handleButtonPress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton('7', handleButtonPress),
                CalculatorButton('8', handleButtonPress),
                CalculatorButton('9', handleButtonPress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton('4', handleButtonPress),
                CalculatorButton('5', handleButtonPress),
                CalculatorButton('6', handleButtonPress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton('1', handleButtonPress),
                CalculatorButton('2', handleButtonPress),
                CalculatorButton('3', handleButtonPress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton('←', handleButtonPress),
                CalculatorButton('0', handleButtonPress),
                CalculatorButton('.', handleButtonPress),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



