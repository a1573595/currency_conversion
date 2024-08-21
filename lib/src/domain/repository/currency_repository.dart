import 'package:currency_conversion/src/domain/model/currency.dart';
import 'package:dio/dio.dart';

abstract class CurrencyRepository {
  Stream<List<Currency>> getCurrencyList({required CancelToken cancelToken});
}
