import 'package:currency_conversion/domain/model/currency.dart';
import 'package:currency_conversion/ui/app_keys.dart';
import 'package:currency_conversion/ui/screen/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/test_util.dart';

void main() async {
  final list = [_currency("AAA", 2), _currency("BBB", 4), _currency("CCC", 8)];

  group("Convert screen test", () {
    testWidgets("Show currency picker", (widgetTester) async {
      await _pumpTestApp(widgetTester, list);

      await widgetTester.tap(find.byKey(AppKeys.convertTab));
      await widgetTester.pump();

      final fromCurrencyCard = find.byKey(AppKeys.fromCurrencyCard);
      await widgetTester.tap(fromCurrencyCard);
      await widgetTester.pumpAndSettle();

      final picker = find.byType(CupertinoPicker);
      expect(fromCurrencyCard, findsOneWidget);
      expect(picker, findsOneWidget);
    });

    testWidgets("Update amount and result", (widgetTester) async {
      await _pumpTestApp(widgetTester, list);
      await _openConvertTab(widgetTester);

      await widgetTester.enterText(find.byKey(AppKeys.convertAmountField), "123");
      await widgetTester.pump();

      expect(find.text("123 AAA"), findsOneWidget);
      expect(find.byKey(AppKeys.convertResultText), findsOneWidget);
      expect(find.text("123.000000000 AAA"), findsOneWidget);
    });

    testWidgets("Save selected to-currency and recalculate result", (widgetTester) async {
      await _pumpTestApp(widgetTester, list);
      await _openConvertTab(widgetTester);

      await widgetTester.enterText(find.byKey(AppKeys.convertAmountField), "123");
      await widgetTester.tap(find.byKey(AppKeys.toCurrencyCard));
      await widgetTester.pumpAndSettle();

      final picker = widgetTester.widget<CupertinoPicker>(find.byKey(AppKeys.currencyPicker));
      picker.onSelectedItemChanged!.call(1);
      await widgetTester.tap(find.byKey(AppKeys.pickerSave));
      await widgetTester.pumpAndSettle();

      expect(find.text("1 AAA ≈ 2.000000000 BBB"), findsOneWidget);
      expect(find.text("246.000000000 BBB"), findsOneWidget);
    });

    testWidgets("Cancel currency picker keeps current result", (widgetTester) async {
      await _pumpTestApp(widgetTester, list);
      await _openConvertTab(widgetTester);

      await widgetTester.tap(find.byKey(AppKeys.toCurrencyCard));
      await widgetTester.pumpAndSettle();

      final picker = widgetTester.widget<CupertinoPicker>(find.byKey(AppKeys.currencyPicker));
      picker.onSelectedItemChanged!.call(1);
      await widgetTester.tap(find.byKey(AppKeys.pickerCancel));
      await widgetTester.pumpAndSettle();

      expect(find.text("1 AAA ≈ 1.000000000 AAA"), findsOneWidget);
      expect(find.text("1.000000000 AAA"), findsOneWidget);
    });

    testWidgets("Switch currencies recalculates result", (widgetTester) async {
      await _pumpTestApp(widgetTester, list);
      await _openConvertTab(widgetTester);

      await widgetTester.enterText(find.byKey(AppKeys.convertAmountField), "123");
      await widgetTester.tap(find.byKey(AppKeys.toCurrencyCard));
      await widgetTester.pumpAndSettle();
      widgetTester.widget<CupertinoPicker>(find.byKey(AppKeys.currencyPicker)).onSelectedItemChanged!.call(1);
      await widgetTester.tap(find.byKey(AppKeys.pickerSave));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byKey(AppKeys.switchCurrencyButton));
      await widgetTester.pumpAndSettle();

      expect(find.text("1 BBB ≈ 0.500000000 AAA"), findsOneWidget);
      expect(find.text("61.500000000 AAA"), findsOneWidget);
    });
  });
}

Future<void> _pumpTestApp(WidgetTester widgetTester, List<Currency> list) async {
  widgetTester.view.physicalSize = const Size(1080, 2400);
  widgetTester.view.devicePixelRatio = 1;
  addTearDown(widgetTester.view.resetPhysicalSize);
  addTearDown(widgetTester.view.resetDevicePixelRatio);

  await widgetTester.pumpWidget(
    buildTestWidget(
      overrides: [currencyListProvider.overrideWith((ref) => Stream.value(list))],
      widget: const HomeScreen(),
    ),
  );
  await widgetTester.pump();
}

Future<void> _openConvertTab(WidgetTester widgetTester) async {
  await widgetTester.tap(find.byKey(AppKeys.convertTab));
  await widgetTester.pump();
}

Currency _currency(String code, double twdPrice) => Currency(code: code, flagImage: "", twdPrice: twdPrice);
