import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:currency_conversion/data/network/currency_api.dart';
import 'package:currency_conversion/data/repository/currency_repository_impl.dart';
import 'package:currency_conversion/domain/local/currency_dao.dart';
import 'package:currency_conversion/domain/model/currency.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/misc.dart';

Currency fakeCurrency(String code, double twdPrice) => Currency(code: code, flagImage: "", twdPrice: twdPrice);

List<Override> fakeApiOverrides({
  Map<String, dynamic>? responseJson,
  Object? apiError,
  List<Currency> cachedCurrencies = const [],
}) {
  final dao = _MemoryCurrencyDao(cachedCurrencies);
  final dio = Dio(BaseOptions(baseUrl: "https://currencyapi.test/"))
    ..httpClientAdapter = _FakeHttpClientAdapter(responseJson: responseJson, error: apiError);

  return [currencyDaoProvider.overrideWithValue(dao), currencyApiProvider.overrideWithValue(CurrencyApiImpl(dio: dio))];
}

Map<String, dynamic> latestCurrencyJson({
  String lastUpdatedAt = "2026-05-11T00:00:00Z",
  required Map<String, Map<String, Object>> currencies,
}) => {
  "meta": {"last_updated_at": lastUpdatedAt},
  "data": currencies,
};

class _MemoryCurrencyDao implements CurrencyDao {
  _MemoryCurrencyDao(List<Currency> cachedCurrencies) : _currencies = [...cachedCurrencies];

  List<Currency> _currencies;

  @override
  Future<List<Currency>> getCurrencyList() async => _currencies;

  @override
  Future<List<Currency>> removeAndPutCurrencyList(List<Currency> currencyList) async {
    _currencies = currencyList
        .map((currency) => Currency(code: currency.code, flagImage: "", twdPrice: currency.twdPrice))
        .toList();
    return _currencies;
  }
}

class _FakeHttpClientAdapter implements HttpClientAdapter {
  _FakeHttpClientAdapter({this.responseJson, this.error});

  final Map<String, dynamic>? responseJson;
  final Object? error;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final error = this.error;
    if (error != null) {
      throw error;
    }

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
