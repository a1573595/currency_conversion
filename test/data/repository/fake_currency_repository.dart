import 'package:currency_conversion/src/domain/model/currency.dart';
import 'package:currency_conversion/src/domain/repository/currency_repository.dart';
import 'package:dio/src/cancel_token.dart';

import '../../source/fake_data_source.dart';

class FakeCurrencyRepository extends CurrencyRepository {
  @override
  Stream<List<Currency>> getCurrencyList({required CancelToken cancelToken}) =>
      Stream.fromFuture(FakeDataSource.currencyList);
}
