import 'package:currency_conversion/common/config.dart';
import 'package:currency_conversion/data/network/currency_api.dart';
import 'package:currency_conversion/domain/network/currency_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._(dio: createDio());

  factory ApiService() => _instance;

  final CurrencyApi _currencyApi;

  CurrencyApi get currencyApi => _currencyApi;

  ApiService._({required Dio dio}) : _currencyApi = CurrencyApiImpl(dio: dio);

  static Dio createDio({
    String baseUrl = Config.baseUrl,
    String apiKey = Config.apiKey,
    bool enableLogger = kDebugMode,
  }) {
    final dio =
        Dio(
            BaseOptions(
              baseUrl: baseUrl,
              headers: {Headers.contentTypeHeader: Headers.jsonContentType, if (apiKey.isNotEmpty) "apikey": apiKey},
            ),
          )
          ..interceptors.add(
            PrettyDioLogger(
              requestHeader: false,
              requestBody: true,
              responseHeader: true,
              responseBody: true,
              enabled: enableLogger,
            ),
          );

    return dio;
  }
}
