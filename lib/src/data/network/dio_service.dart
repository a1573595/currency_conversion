import 'package:currency_conversion/src/common/config.dart';
import 'package:currency_conversion/src/data/network/currency_api.dart';
import 'package:currency_conversion/src/domain/network/currency_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._();

  factory ApiService() => _instance;

  late final CurrencyApi _currencyApi;

  CurrencyApi get currencyApi => _currencyApi;

  ApiService._() {
    final dio = Dio(BaseOptions(
      baseUrl: Config.baseUrl,
      headers: {Headers.contentTypeHeader: Headers.jsonContentType, "apikey": Config.apiKey},
    ))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        enabled: kDebugMode,
      ));

    _currencyApi = CurrencyApiImpl(dio: dio);
  }
}
