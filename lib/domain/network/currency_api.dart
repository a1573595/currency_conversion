import 'package:currency_conversion/data/model/latest_currency.dart';
import 'package:dio/dio.dart';

abstract class CurrencyApi {
  Future<LatestCurrency> getCurrencyList(String baseCurrency, {required CancelToken cancelToken});
}
