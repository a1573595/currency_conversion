import 'package:currency_conversion/data/model/latest_currency.dart';
import 'package:currency_conversion/data/repository/currency_repository_impl.dart';
import 'package:currency_conversion/domain/local/currency_dao.dart';
import 'package:currency_conversion/domain/model/currency.dart';
import 'package:currency_conversion/domain/network/currency_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("CurrencyRepositoryImpl", () {
    test("emits cached currencies before refreshed API currencies", () async {
      final cachedCurrency = _currency("USD", 31.2);
      final apiCurrency = _currencyRaw("JPY", 0.21);
      final dao = _RecordingCurrencyDao(cachedCurrencies: [cachedCurrency]);
      final api = _RecordingCurrencyApi(latestCurrency: _latestCurrency([apiCurrency]));
      final repository = CurrencyRepositoryImpl(currencyDao: dao, currencyApi: api);

      await expectLater(
        repository.getCurrencyList(cancelToken: CancelToken()),
        emitsInOrder([
          [cachedCurrency],
          [Currency.fromRaw(apiCurrency)],
          emitsDone,
        ]),
      );
    });

    test("does not emit an empty cache before refreshed API currencies", () async {
      final apiCurrency = _currencyRaw("USD", 31.2);
      final dao = _RecordingCurrencyDao(cachedCurrencies: []);
      final api = _RecordingCurrencyApi(latestCurrency: _latestCurrency([apiCurrency]));
      final repository = CurrencyRepositoryImpl(currencyDao: dao, currencyApi: api);

      await expectLater(
        repository.getCurrencyList(cancelToken: CancelToken()),
        emitsInOrder([
          [Currency.fromRaw(apiCurrency)],
          emitsDone,
        ]),
      );
    });

    test("requests TWD with the provided cancel token", () async {
      final cancelToken = CancelToken();
      final dao = _RecordingCurrencyDao(cachedCurrencies: []);
      final api = _RecordingCurrencyApi(latestCurrency: _latestCurrency([_currencyRaw("USD", 31.2)]));
      final repository = CurrencyRepositoryImpl(currencyDao: dao, currencyApi: api);

      await repository.getCurrencyList(cancelToken: cancelToken).drain<void>();

      expect(api.requestedBaseCurrency, "TWD");
      expect(api.requestedCancelToken, same(cancelToken));
      expect(api.callCount, 1);
    });

    test("filters API currencies below 0.01 before saving and emitting", () async {
      final keptCurrency = _currencyRaw("USD", 31.2);
      final boundaryCurrency = _currencyRaw("JPY", 0.01);
      final filteredCurrency = _currencyRaw("VND", 0.009);
      final dao = _RecordingCurrencyDao(cachedCurrencies: []);
      final api = _RecordingCurrencyApi(
        latestCurrency: _latestCurrency([keptCurrency, boundaryCurrency, filteredCurrency]),
      );
      final repository = CurrencyRepositoryImpl(currencyDao: dao, currencyApi: api);
      final expectedCurrencies = [Currency.fromRaw(keptCurrency), Currency.fromRaw(boundaryCurrency)];

      await expectLater(
        repository.getCurrencyList(cancelToken: CancelToken()),
        emitsInOrder([expectedCurrencies, emitsDone]),
      );
      expect(dao.savedCurrencyLists, [expectedCurrencies]);
    });

    test("keeps cached currencies when refresh fails", () async {
      final exception = Exception("network unavailable");
      final cachedCurrency = _currency("USD", 31.2);
      final dao = _RecordingCurrencyDao(cachedCurrencies: [cachedCurrency]);
      final api = _RecordingCurrencyApi(error: exception);
      final repository = CurrencyRepositoryImpl(currencyDao: dao, currencyApi: api);

      await expectLater(
        repository.getCurrencyList(cancelToken: CancelToken()),
        emitsInOrder([
          [cachedCurrency],
          emitsDone,
        ]),
      );
      expect(dao.savedCurrencyLists, isEmpty);
    });

    test("propagates API errors when no cache is available", () async {
      final exception = Exception("network unavailable");
      final dao = _RecordingCurrencyDao(cachedCurrencies: []);
      final api = _RecordingCurrencyApi(error: exception);
      final repository = CurrencyRepositoryImpl(currencyDao: dao, currencyApi: api);

      await expectLater(
        repository.getCurrencyList(cancelToken: CancelToken()),
        emitsInOrder([emitsError(same(exception)), emitsDone]),
      );
      expect(dao.savedCurrencyLists, isEmpty);
    });
  });
}

Currency _currency(String code, double twdPrice) =>
    Currency(code: code, flagImage: "https://flagsapi.com/${code[0]}${code[1]}/flat/32.png", twdPrice: twdPrice);

CurrencyRaw _currencyRaw(String code, double value) => CurrencyRaw(code: code, value: value);

LatestCurrency _latestCurrency(List<CurrencyRaw> currencies) => LatestCurrency(
  meta: Meta(lastUpdatedAt: "2026-05-11T00:00:00Z"),
  data: {for (final currency in currencies) currency.code: currency},
);

class _RecordingCurrencyDao implements CurrencyDao {
  final List<Currency> cachedCurrencies;
  final List<List<Currency>> _savedCurrencyLists = [];

  _RecordingCurrencyDao({required this.cachedCurrencies});

  List<List<Currency>> get savedCurrencyLists => _savedCurrencyLists;

  @override
  Future<List<Currency>> getCurrencyList() async => cachedCurrencies;

  @override
  Future<List<Currency>> removeAndPutCurrencyList(List<Currency> currencyList) async {
    _savedCurrencyLists.add(currencyList);
    return currencyList;
  }
}

class _RecordingCurrencyApi implements CurrencyApi {
  final LatestCurrency? latestCurrency;
  final Object? error;
  String? requestedBaseCurrency;
  CancelToken? requestedCancelToken;
  int callCount = 0;

  _RecordingCurrencyApi({this.latestCurrency, this.error});

  @override
  Future<LatestCurrency> getCurrencyList(String baseCurrency, {required CancelToken cancelToken}) async {
    callCount += 1;
    requestedBaseCurrency = baseCurrency;
    requestedCancelToken = cancelToken;

    final error = this.error;
    if (error != null) {
      throw error;
    }

    return latestCurrency!;
  }
}
