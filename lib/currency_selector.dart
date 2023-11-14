import 'package:currency_calculator/common/currency.dart';
import 'package:flutter/cupertino.dart';

class CurrencySelector extends StatelessWidget {
  final Function(Currency) onCurrencySelected; 
  final Currency selectedCurrency;
  final List<Currency> currencies;

  const CurrencySelector(this.currencies, this.onCurrencySelected, this.selectedCurrency, {super.key});

  @override
  Widget build(BuildContext context) {

    return CupertinoPicker(
      itemExtent: 40, 
      magnification:1.10 ,
      onSelectedItemChanged: (int selectedItem) {
        onCurrencySelected(currencies[selectedItem]);
      },
      scrollController: FixedExtentScrollController(
        initialItem: currencies.indexOf(selectedCurrency), 
        
      ),
      children: 
        List<Widget>.generate(currencies.length, (index) {
          return buildCurrencySelection(currencies[index]);
        })
    );
  }
}

Widget buildCurrencySelection(Currency currency) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
            child: 
              Text( 
                currency.flagText,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
          ),
          Expanded( 
            child: Text(
              "  ${currency.name ?? ""}",
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 24.0),
            ),
          )
      ],

    );
}