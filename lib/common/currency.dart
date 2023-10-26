class Currency {
  String? _code;
  String? _name;   
  String? _symbol;
  String? _flag;
  double? _usdRate;
  int? _decimalDigits;

  String? get code => _code;
  String? get name => _name;
  String? get symbol => _symbol;
  String? get flag => _flag;
  double? get usdRate => _usdRate;
  int? get decimalDigits => _decimalDigits;

  set usdRate (double? usdRate) => _usdRate = usdRate;
  

  Currency({String? code, String? name, String? symbol, String flag = "", double usdRate = 1, int decimalDigits = 2}) {
    _code = code;
    _name = name;
    _symbol = symbol;
    _flag = flag;
    _usdRate = usdRate;
    _decimalDigits = decimalDigits;
  }

  static Currency fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      name: json['name'],
      symbol: json['symbol_native'],
    );
  }

  static Currency usd = Currency(code: "USD", name: "United States Dollar", symbol: "\$", flag: "🇺🇸", usdRate: 1);
  
}

