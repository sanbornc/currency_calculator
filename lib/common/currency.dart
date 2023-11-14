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

Map<String, String> currencyToFlag = {
  "AUD": "🇦🇺",
  "BGN": "🇧🇬",
  "BRL": "🇧🇷",
  "CAD": "🇨🇦",
  "CHF": "🇨🇭",
  "CNY": "🇨🇳",
  "CZK": "🇨🇿",
  "DKK": "🇩🇰",
  "EUR": "🇪🇺",
  "GBP": "🇬🇧",
  "HKD": "🇭🇰",
  "HRK": "🇭🇷",
  "HUF": "🇭🇺",
  "IDR": "🇮🇩",
  "ILS": "🇮🇱",
  "INR": "🇮🇳",
  "ISK": "🇮🇸",
  "JPY": "🇯🇵",
  "KRW": "🇰🇷",
  "MXN": "🇲🇽",
  "MYR": "🇲🇾",
  "NOK": "🇳🇴",
  "NZD": "🇳🇿",
  "PHP": "🇵🇭",
  "PLN": "🇵🇱",
  "RON": "🇷🇴",
  "RUB": "🇷🇺",
  "SEK": "🇸🇪",
  "SGD": "🇸🇬",
  "THB": "🇹🇭",
  "TRY": "🇹🇷",
  "USD": "🇺🇸",
  "ZAR": "🇿🇦",
};

  String get flagText {
    if (currencyToFlag.containsKey(_code)) { 
      return currencyToFlag[_code] ?? '?';
    } else {
      return _code ?? '?';
    }
  }

  set usdRate (double? usdRate) => _usdRate = usdRate;
  

  Currency({String? code, String? name, String? symbol, double usdRate = 1, int decimalDigits = 2}) {
    _code = code;
    _name = name;
    _symbol = symbol;
    _usdRate = usdRate;
    _decimalDigits = decimalDigits;
  }

  static Currency usd = Currency(code: "USD", name: "United States Dollar", symbol: "\$", usdRate: 1);
  
}