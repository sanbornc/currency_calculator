import 'package:currency_calculator/common/currency.dart';

class Conversion {
  Currency? currency;
  //double _amount = 1;
  bool isBase = false;
  String _rawText = "";

  Conversion({String rawText = "", this.currency, this.isBase = false}) {
    _rawText = rawText;
  }

  double get amount {
    if(_rawText == "" || _rawText == "0." || _rawText == ".") {
      return 0;
    }
     
    return double.parse(_rawText);
  }
  
  set amount(double amount) => _rawText = amount.toString();

  String get displayText => isBase ? _rawText : amount.toStringAsFixed(currency?.decimalDigits ?? 0);



  void calculateAmount(Conversion source) {
    amount = source.amount * currency!.usdRate! / source.currency!.usdRate!;
  }

  void backSpace() {
    if (_rawText.isNotEmpty){
      _rawText = _rawText.substring(0, _rawText.length - 1);
    }
  }

  void appendDigit(int digit) {
    if(_rawText =="0." || _rawText == "." || amount > 0) {
      _rawText = _rawText + digit.toString();
    } else {
      _rawText = digit.toString();
    }
  }

  void addDecimal() {
    if(!_rawText.contains(".")) {
      _rawText = "$_rawText.";
    }
  }

  void clear() {
    _rawText = "";
  }

  static Conversion getBase() => Conversion(currency: Currency.usd, isBase: true);
  static Conversion getTarget() => Conversion(currency: Currency.usd, isBase: false);
  
}