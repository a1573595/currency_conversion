import 'package:currency_conversion/src/domain/model/currency.dart';

abstract class CurrencyDao {
  Future<List<Currency>> getCurrencyList();

  Future<List<Currency>> removeAndPutCurrencyList(List<Currency> currencyList);
}
