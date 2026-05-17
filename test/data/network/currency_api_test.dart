import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:currency_conversion/data/network/currency_api.dart';
import 'package:currency_conversion/data/network/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ApiService", () {
    test("creates Dio with JSON content type and API key header", () {
      final dio = ApiService.createDio(baseUrl: "https://example.test/", apiKey: "test-api-key", enableLogger: false);

      expect(dio.options.baseUrl, "https://example.test/");
      expect(dio.options.headers[Headers.contentTypeHeader], Headers.jsonContentType);
      expect(dio.options.headers["apikey"], "test-api-key");
    });

    test("omits API key header when key is empty", () {
      final dio = ApiService.createDio(baseUrl: "https://example.test/", apiKey: "", enableLogger: false);

      expect(dio.options.headers.containsKey("apikey"), false);
    });
  });

  group("CurrencyApiImpl", () {
    test("builds latest-currency request and passes cancel token to Dio", () async {
      final adapter = _RecordingHttpClientAdapter(responseJson: _latestCurrencyJson());
      final dio = Dio(BaseOptions(baseUrl: "https://example.test/"))..httpClientAdapter = adapter;
      final api = CurrencyApiImpl(dio: dio);
      final cancelToken = CancelToken();

      await api.getCurrencyList("TWD", cancelToken: cancelToken);

      expect(adapter.requestOptions?.method, "GET");
      expect(adapter.requestOptions?.path, "v3/latest?base_currency=TWD");
      expect(adapter.cancelFuture, same(cancelToken.whenCancel));
    });

    test("parses latest-currency JSON into model objects", () async {
      final adapter = _RecordingHttpClientAdapter(
        responseJson: _latestCurrencyJson(
          lastUpdatedAt: "2026-05-11T12:34:56Z",
          currencies: {
            "USD": {"code": "USD", "value": 31},
            "JPY": {"code": "JPY", "value": 0.21},
          },
        ),
      );
      final dio = Dio(BaseOptions(baseUrl: "https://example.test/"))..httpClientAdapter = adapter;
      final api = CurrencyApiImpl(dio: dio);

      final latestCurrency = await api.getCurrencyList("TWD", cancelToken: CancelToken());

      expect(latestCurrency.meta.lastUpdatedAt, "2026-05-11T12:34:56Z");
      expect(latestCurrency.data.keys, containsAll(["USD", "JPY"]));
      expect(latestCurrency.data["USD"]?.code, "USD");
      expect(latestCurrency.data["USD"]?.value, 31.0);
      expect(latestCurrency.data["JPY"]?.value, 0.21);
    });
  });
}

Map<String, dynamic> _latestCurrencyJson({
  String lastUpdatedAt = "2026-05-11T00:00:00Z",
  Map<String, Map<String, Object>> currencies = const {
    "USD": {"code": "USD", "value": 31.2},
  },
}) => {
  "meta": {"last_updated_at": lastUpdatedAt},
  "data": currencies,
};

class _RecordingHttpClientAdapter implements HttpClientAdapter {
  final Map<String, dynamic> responseJson;
  RequestOptions? requestOptions;
  Future<void>? cancelFuture;

  _RecordingHttpClientAdapter({required this.responseJson});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestOptions = options;
    this.cancelFuture = cancelFuture;

    return ResponseBody.fromString(
      jsonEncode(responseJson),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
