import 'package:currency_conversion/src/ui/screen/bean/convert_ui_state.dart';
import 'package:currency_conversion/src/ui/screen/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/test_util.dart';
import '../../source/fake_data_source.dart';


void main() async {
  final list = await FakeDataSource.currencyList;

  group("Home view model", () {
    test("ConvertUiStateNotifier init state", () async {
      final container = createContainer(
        overrides: [
          currencyListProvider.overrideWith((ref) => Stream.value(list)),
        ],
      );

      await container.read(currencyListProvider.future);

      final uiState = container.read(convertUiStateProvider);
      expect(uiState, ConvertUiState.byDefault(currency: list.first));
    });

    test("ConvertUiStateNotifier update amount text", () async {
      const amountText = "123";

      final container = createContainer(
        overrides: [
          currencyListProvider.overrideWith((ref) => Stream.value(list)),
        ],
      );

      await container.read(currencyListProvider.future);

      container.read(convertUiStateProvider.notifier).updateAmountText(amountText);

      final uiState = container.read(convertUiStateProvider);
      expect(uiState.amountText, amountText);
      expect(uiState.resultText, "123.000000000");
    });

    test("ConvertUiStateNotifier switch exchange", () async {
      const amountText = "123";

      final container = createContainer(
        overrides: [
          currencyListProvider.overrideWith((ref) => Stream.value(list)),
        ],
      );

      await container.read(currencyListProvider.future);

      container.read(convertUiStateProvider.notifier).updateAmountText(amountText);
      container.read(convertUiStateProvider.notifier).updateToCurrency(list.last);

      expect(container.read(convertUiStateProvider).resultText, "365.057060105");

      container.read(convertUiStateProvider.notifier).switchCurrency();
      expect(container.read(convertUiStateProvider).resultText, "41.442836349");
    });
  });
}
