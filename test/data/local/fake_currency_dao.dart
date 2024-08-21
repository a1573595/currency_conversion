import 'package:currency_conversion/src/domain/local/currency_dao.dart';
import 'package:currency_conversion/src/domain/model/currency.dart';

import '../../source/fake_data_source.dart';

class FakeCurrencyDao implements CurrencyDao {
  @override
  Future<List<Currency>> getCurrencyList() => FakeDataSource.currencyList;

  @override
  Future<List<Currency>> removeAndPutCurrencyList(List<Currency> currencyList) => Future.value(currencyList);
}
