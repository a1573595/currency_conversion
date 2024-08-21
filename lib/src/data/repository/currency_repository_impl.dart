import 'package:currency_conversion/src/data/local/object_box_help.dart';
import 'package:currency_conversion/src/data/network/dio_service.dart';
import 'package:currency_conversion/src/domain/local/currency_dao.dart';
import 'package:currency_conversion/src/domain/model/currency.dart';
import 'package:currency_conversion/src/domain/network/currency_api.dart';
import 'package:currency_conversion/src/domain/repository/currency_repository.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currencyRepository = Provider<CurrencyRepository>((ref) => CurrencyRepositoryImpl(
      currencyDao: ObjectBoxHelp.currencyDao,
      currencyApi: ApiService().currencyApi,
    ));

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyDao _dao;
  final CurrencyApi _api;

  const CurrencyRepositoryImpl({
    required CurrencyDao currencyDao,
    required CurrencyApi currencyApi,
  })  : _dao = currencyDao,
        _api = currencyApi;

  @override
  Stream<List<Currency>> getCurrencyList({required CancelToken cancelToken}) async* {
    final list = await _dao.getCurrencyList();

    if (list.isNotEmpty) {
      yield list;
    }

    yield await _api
        .getCurrencyList("TWD", cancelToken: cancelToken)
        .then((value) => value.data.values.where((e) => e.value >= 0.01))
        .then((value) => value.map((e) => Currency.fromRaw(e)).toList())
        .then((value) => _dao.removeAndPutCurrencyList(value));
  }
}
