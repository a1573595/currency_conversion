import 'dart:convert';
import 'dart:io';

import 'package:currency_conversion/src/data/model/latest_currency.dart';
import 'package:currency_conversion/src/domain/model/currency.dart';

class FakeDataSource {
  FakeDataSource._();

  static String _testPath(String relativePath) {
    final current = Directory.current.path;
    String path = current.endsWith('/test') ? current : '$current/test';
    return '$path/$relativePath';
  }

  static Future<LatestCurrency> get latestCurrency => File(_testPath('source/latest_currency.json'))
      .readAsString()
      .then((value) => jsonDecode(value))
      .then((value) => LatestCurrency.fromJson(value));

  static Future<List<Currency>> get currencyList =>
      latestCurrency.then((value) => value.data.values.map((e) => Currency.fromRaw(e)).toList());
}
