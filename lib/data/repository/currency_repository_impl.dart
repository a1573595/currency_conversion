import 'package:currency_conversion/data/local/object_box_help.dart';
import 'package:currency_conversion/data/network/dio_service.dart';
import 'package:currency_conversion/domain/local/currency_dao.dart';
import 'package:currency_conversion/domain/model/currency.dart';
import 'package:currency_conversion/domain/network/currency_api.dart';
import 'package:currency_conversion/domain/repository/currency_repository.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currencyDaoProvider = Provider<CurrencyDao>((ref) => ObjectBoxHelp.currencyDao);

final currencyApiProvider = Provider<CurrencyApi>((ref) => ApiService().currencyApi);

final currencyRepository = Provider<CurrencyRepository>(
  (ref) =>
      CurrencyRepositoryImpl(currencyDao: ref.watch(currencyDaoProvider), currencyApi: ref.watch(currencyApiProvider)),
);

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyDao _dao;
  final CurrencyApi _api;

  const CurrencyRepositoryImpl({required CurrencyDao currencyDao, required CurrencyApi currencyApi})
    : _dao = currencyDao,
      _api = currencyApi;

  @override
  Stream<List<Currency>> getCurrencyList({required CancelToken cancelToken}) async* {
    final list = await _dao.getCurrencyList();

    if (list.isNotEmpty) {
      yield list;
    }

    try {
      yield await _api
          .getCurrencyList("TWD", cancelToken: cancelToken)
          .then((value) => value.data.values.where((e) => e.value >= 0.01))
          .then((value) => value.map((e) => Currency.fromRaw(e)).toList())
          .then((value) => _dao.removeAndPutCurrencyList(value));
    } catch (_) {
      if (list.isEmpty) {
        rethrow;
      }
    }
  }
}
