import 'dart:async';

import 'package:currency_conversion/domain/model/currency.dart';
import 'package:currency_conversion/ui/screen/bean/convert_ui_state.dart';
import 'package:currency_conversion/ui/screen/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/test_util.dart';

void main() async {
  final list = [_currency("AAA", 2), _currency("BBB", 4), _currency("CCC", 8)];

  Future<void> waitCurrencyList(ProviderContainer container) async {
    final subscription = container.listen(currencyListProvider, (_, _) {});
    addTearDown(subscription.close);

    await container.read(currencyListProvider.future);
  }

  group("Home view model", () {
    test("ConvertUiStateNotifier init state", () async {
      final container = createContainer(overrides: [currencyListProvider.overrideWith((ref) => Stream.value(list))]);

      await waitCurrencyList(container);

      final uiState = container.read(convertUiStateProvider);
      expect(uiState, ConvertUiState.byDefault(currency: list.first));
    });

    test("ConvertUiStateNotifier update amount text", () async {
      const amountText = "123";

      final container = createContainer(overrides: [currencyListProvider.overrideWith((ref) => Stream.value(list))]);

      await waitCurrencyList(container);

      container.read(convertUiStateProvider.notifier).updateAmountText(amountText);

      final uiState = container.read(convertUiStateProvider);
      expect(uiState.amountText, amountText);
      expect(uiState.resultText, "123.000000000");
    });

    test("ConvertUiStateNotifier normalizes invalid amount text to zero", () async {
      final container = createContainer(overrides: [currencyListProvider.overrideWith((ref) => Stream.value(list))]);

      await waitCurrencyList(container);

      container.read(convertUiStateProvider.notifier).updateAmountText("");

      var uiState = container.read(convertUiStateProvider);
      expect(uiState.amountText, "0");
      expect(uiState.resultText, "0.000000000");

      container.read(convertUiStateProvider.notifier).updateAmountText("abc");

      uiState = container.read(convertUiStateProvider);
      expect(uiState.amountText, "0");
      expect(uiState.resultText, "0.000000000");
    });

    test("ConvertUiStateNotifier updates from and to currencies", () async {
      final container = createContainer(overrides: [currencyListProvider.overrideWith((ref) => Stream.value(list))]);

      await waitCurrencyList(container);

      container.read(convertUiStateProvider.notifier).updateAmountText("123");
      container.read(convertUiStateProvider.notifier).updateToCurrency(list[1]);

      var uiState = container.read(convertUiStateProvider);
      expect(uiState.fromCurrency, list[0]);
      expect(uiState.toCurrency, list[1]);
      expect(uiState.rateText, "2.000000000");
      expect(uiState.resultText, "246.000000000");

      container.read(convertUiStateProvider.notifier).updateFromCurrency(list[1]);

      uiState = container.read(convertUiStateProvider);
      expect(uiState.fromCurrency, list[1]);
      expect(uiState.toCurrency, list[1]);
      expect(uiState.rateText, "1.000000000");
      expect(uiState.resultText, "123.000000000");
    });

    test("ConvertUiStateNotifier switch exchange", () async {
      const amountText = "123";

      final container = createContainer(overrides: [currencyListProvider.overrideWith((ref) => Stream.value(list))]);

      await waitCurrencyList(container);

      container.read(convertUiStateProvider.notifier).updateAmountText(amountText);
      container.read(convertUiStateProvider.notifier).updateToCurrency(list[1]);

      expect(container.read(convertUiStateProvider).resultText, "246.000000000");

      container.read(convertUiStateProvider.notifier).switchCurrency();
      expect(container.read(convertUiStateProvider).fromCurrency, list[1]);
      expect(container.read(convertUiStateProvider).toCurrency, list[0]);
      expect(container.read(convertUiStateProvider).rateText, "0.500000000");
      expect(container.read(convertUiStateProvider).resultText, "61.500000000");
    });

    test("ConvertUiStateNotifier recalculates when refreshed currency data arrives", () async {
      final controller = StreamController<List<Currency>>();
      addTearDown(controller.close);
      final container = createContainer(overrides: [currencyListProvider.overrideWith((ref) => controller.stream)]);
      controller.add(list);
      await waitCurrencyList(container);
      final refreshCompleter = Completer<ConvertUiState>();
      final convertSubscription = container.listen(convertUiStateProvider, (_, next) {
        if (next.resultText == "50.000000000" && !refreshCompleter.isCompleted) {
          refreshCompleter.complete(next);
        }
      });
      addTearDown(convertSubscription.close);

      container.read(convertUiStateProvider.notifier).updateAmountText("10");
      container.read(convertUiStateProvider.notifier).updateToCurrency(list[1]);

      expect(container.read(convertUiStateProvider).resultText, "20.000000000");

      controller.add([_currency("AAA", 2), _currency("BBB", 10), _currency("CCC", 8)]);

      final uiState = await refreshCompleter.future.timeout(const Duration(seconds: 1));
      expect(uiState.rateText, "5.000000000");
      expect(uiState.resultText, "50.000000000");
    });
  });
}

Currency _currency(String code, double twdPrice) => Currency(code: code, flagImage: "", twdPrice: twdPrice);
