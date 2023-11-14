import 'dart:convert';

import 'package:currency_calculator/common/currency.dart';
import 'package:http/http.dart' as http;

class CurrencyRepo {
  static Future<List<Currency>> fetchCurrencies() async {

    var result = List<Currency>.empty(growable: true);

    var currencies = await _getCurrencies();

    if (currencies.statusCode == 200) {

      var currenciesJson = jsonDecode(currencies.body);

      Map<String, dynamic> currenciesMap = currenciesJson["data"].cast<String, dynamic>();
      for (var currency in currenciesMap.entries) {
        result.add(Currency(code: currency.key, name: currency.value["name"], symbol: currency.value["symbol"]));
      }
    }

    var rates = await _getRates();
    if (rates.statusCode == 200) {
      var ratesResponse = jsonDecode(rates.body);

      for (var currency in result) {
        currency.usdRate = ratesResponse["data"][currency.code].toDouble();
      }
    }

    return result;
  }

  static Future<http.Response> _getCurrencies() {
    
    return http.get(
      Uri.parse("https://api.freecurrencyapi.com/v1/currencies?apikey=fca_live_vDsMlBqELAiThMZbPuxEqXBcjUVE3j10Q9ioL5c7"));

  }

  static Future<http.Response> _getRates() {
    return http.get(
      Uri.parse("https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_vDsMlBqELAiThMZbPuxEqXBcjUVE3j10Q9ioL5c7"));
  } 
}
