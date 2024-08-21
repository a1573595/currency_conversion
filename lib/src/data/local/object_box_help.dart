import 'package:currency_conversion/src/data/local/currency_dao_impl.dart';
import 'package:currency_conversion/src/data/local/objectbox.g.dart';
import 'package:currency_conversion/src/domain/local/currency_dao.dart';
import 'package:currency_conversion/src/domain/model/currency.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxHelp {
  const ObjectBoxHelp._();

  static late final Store _store;

  static late final CurrencyDao _currencyDao;

  static CurrencyDao get currencyDao => _currencyDao;

  static Future<void> init() => getApplicationDocumentsDirectory()
      .then((value) => openStore(directory: "${value.path}/currency-db"))
      .then((value) => _store = value)
      .then((value) => Box<Currency>(value))
      .then((value) => _currencyDao = CurrencyDaoImpl(value));

  static void close() => _store.close();
}
