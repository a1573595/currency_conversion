import 'package:currency_conversion/src/data/network/dio_service.dart';
import 'package:currency_conversion/src/domain/model/currency.dart';
import 'package:currency_conversion/src/domain/network/currency_api.dart';
import 'package:currency_conversion/src/domain/repository/currency_repository.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currencyRepository = Provider<CurrencyRepository>((ref) => CurrencyRepositoryImpl(
      currencyApi: ApiService().currencyApi,
    ));

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyApi _api;

  const CurrencyRepositoryImpl({
    required CurrencyApi currencyApi,
  }) : _api = currencyApi;

  @override
  Future<List<Currency>> getCurrencyListBaseTWD({required CancelToken cancelToken}) => _api
      .getCurrencyList("TWD", cancelToken: cancelToken)
      .then((value) => value.data.values.where((e) => e.value >= 0.01).map((e) => Currency.fromRaw(e)).toList());
}
