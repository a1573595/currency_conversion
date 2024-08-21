import 'package:currency_conversion/src/data/model/latest_currency.dart';
import 'package:currency_conversion/src/domain/network/currency_api.dart';
import 'package:dio/src/cancel_token.dart';

import '../../source/fake_data_source.dart';

class FakeCurrencyApi implements CurrencyApi {
  @override
  Future<LatestCurrency> getCurrencyList(String baseCurrency, {required CancelToken cancelToken}) =>
      FakeDataSource.latestCurrency;
}
