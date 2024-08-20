import 'package:currency_conversion/src/domain/model/currency.dart';
import 'package:dio/dio.dart';

abstract class CurrencyRepository {
  Future<List<Currency>> getCurrencyListBaseTWD({required CancelToken cancelToken});
}
