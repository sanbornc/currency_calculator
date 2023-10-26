import 'package:currency_calculator/common/currency.dart';
import 'package:flutter/cupertino.dart';

class CurrencySelector extends StatelessWidget {
  final Function(Currency) onCurrencySelected; 
  final Currency selectedCurrency;
  final List<Currency> currencies;

  const CurrencySelector(this.currencies, this.onCurrencySelected, this.selectedCurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoPicker(
      itemExtent: 32, 
      onSelectedItemChanged: (int selectedItem) {
        onCurrencySelected(currencies[selectedItem]);
      },
      scrollController: FixedExtentScrollController(initialItem: currencies.indexOf(selectedCurrency)),
      children: 
        List<Widget>.generate(currencies.length, (index) {
          return buildCurrencySelection(currencies[index]);
        })
    );
  }
}

Widget buildCurrencySelection(Currency currency) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: 
              Text( 
                currency.flag ?? "",
              ),
          ),
          Expanded( 
            child: Text(
              currency.name ?? "",
              textAlign: TextAlign.center,
            ),
          )
      ],

    );
}