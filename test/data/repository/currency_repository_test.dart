import 'package:collection/collection.dart';
import 'package:currency_conversion/src/data/repository/currency_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../source/fake_data_source.dart';
import '../local/fake_currency_dao.dart';
import '../network/fake_currency_api.dart';

void main() {
  final repository = CurrencyRepositoryImpl(
    currencyDao: FakeCurrencyDao(),
    currencyApi: FakeCurrencyApi(),
  );

  group("Currency repository test", () {
    test("getCurrencyList", () async {
      final expectedResult = await FakeDataSource.currencyList;

      final actualResult = await repository.getCurrencyList(cancelToken: CancelToken()).first;

      expect(const ListEquality().equals(actualResult, expectedResult), true);
    });
  });
}
