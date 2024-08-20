import 'package:currency_conversion/src/data/model/latest_currency.dart';
import 'package:currency_conversion/src/domain/network/currency_api.dart';
import 'package:dio/dio.dart';

class CurrencyApiImpl implements CurrencyApi {
  final Dio _dio;

  const CurrencyApiImpl({required Dio dio}) : _dio = dio;

  @override
  Future<LatestCurrency> getCurrencyList(String baseCurrency, {required CancelToken cancelToken}) => _dio
      .get('v3/latest?base_currency=$baseCurrency', cancelToken: cancelToken)
      .then((value) => LatestCurrency.fromJson(value.data));
}
