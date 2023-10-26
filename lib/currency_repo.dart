import 'dart:convert';

import 'package:currency_calculator/common/currency.dart';
import 'package:http/http.dart' as http;

class CurrencyRepo {
  static Future<List<Currency>> fetchCurrencies() async {

    var result = List<Currency>.empty(growable: true);
    var currencies = await _getCurrencies();

    if (currencies.statusCode == 200) {

      //var currenciesJson = currencies.body;
      //print(currenciesJson);
      var currenciesJson = jsonDecode(currencies.body);
      //print(currenciesJson);
      result = currenciesJson.map((json) => Currency.fromJson(json)).toList();  
    }

    var rates = await _getRates();
    if (rates.statusCode == 200) {
      var ratesResponse = jsonDecode(rates.body);

      // var lastUpdated = ratesResponse["meta"]["last_updated_at"];
      //Map<String, double> rateMap = ratesResponse["data"].cast<String, double>();

      for (var currency in result) {
        currency.usdRate = ratesResponse["data"][currency.code];
      }
    }

    return result;


      // return [
      //   Currency(code: "USD", name: "United States Dollar", symbol: "\$", flag: "🇺🇸", usdRate: 1),
      //   Currency(code: "EUR", name: "Euro", symbol: "€", flag: "🇪🇺", usdRate: 0.85),
      //   Currency(code: "GBP", name: "British Pound", symbol: "£", flag: "🇬🇧", usdRate: 0.72),
      //   Currency(code: "JPY", name: "Japanese Yen", symbol: "¥", flag: "🇯🇵", usdRate: 109.84),
      //   Currency(code: "AUD", name: "Australian Dollar", symbol: "\$", flag: "🇦🇺", usdRate: 1.29),
      //   Currency(code: "CAD", name: "Canadian Dollar", symbol: "\$", flag: "🇨🇦", usdRate: 1.26),
      // ];
   // ...
  }
  static Future<http.Response> _getCurrencies() {
    
    var httpClient = http.Client() as http.BaseClient;

    

    var result = httpClient.get(
      Uri.parse("https://api.freecurrencyapi.net/v1/currencies"), 
        headers: {"apikey": "fca_live_vDsMlBqELAiThMZbPuxEqXBcjUVE3j10Q9ioL5c7"});

    httpClient.close();
    return result;

  }

  static Future<http.Response> _getRates() {
    return http.get(
      Uri.parse("https://api.freecurrencyapi.net/v1/latest"), 
        headers: {"apikey": "fca_live_vDsMlBqELAiThMZbPuxEqXBcjUVE3j10Q9ioL5c7"});
  } 
}

//https://api.freecurrencyapi.com/v1/currencies
//fca_live_vDsMlBqELAiThMZbPuxEqXBcjUVE3j10Q9ioL5c7

//get_it -> https://pub.dev/packages/get_it IOC
//dio -> https://pub.dev/packages/dio http client