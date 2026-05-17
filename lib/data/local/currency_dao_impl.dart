import 'package:currency_conversion/data/local/objectbox.g.dart';
import 'package:currency_conversion/domain/local/currency_dao.dart';
import 'package:currency_conversion/domain/model/currency.dart';

class CurrencyDaoImpl implements CurrencyDao {
  final Box<Currency> _box;

  const CurrencyDaoImpl(Box<Currency> box) : _box = box;

  @override
  Future<List<Currency>> getCurrencyList() => _box.getAllAsync();

  @override
  Future<List<Currency>> removeAndPutCurrencyList(List<Currency> currencyList) async {
    await _box.removeAllAsync();
    return _box.putAndGetManyAsync(currencyList);
  }
}
