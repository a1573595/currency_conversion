import 'package:currency_conversion/ui/app_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> openConvertTab(WidgetTester tester) async {
  await tester.tap(find.byKey(AppKeys.convertTab));
  await tester.pumpAndSettle();
}

Future<void> enterAmount(WidgetTester tester, String amount) async {
  await tester.enterText(find.byKey(AppKeys.convertAmountField), amount);
  await tester.pumpAndSettle();
}

Future<void> selectToCurrencyAtIndex(WidgetTester tester, int index) async {
  await tester.tap(find.byKey(AppKeys.toCurrencyCard));
  await tester.pumpAndSettle();

  tester.widget<CupertinoPicker>(find.byKey(AppKeys.currencyPicker)).onSelectedItemChanged!.call(index);
  await tester.tap(find.byKey(AppKeys.pickerSave));
  await tester.pumpAndSettle();
}

Future<void> switchCurrencies(WidgetTester tester) async {
  await tester.tap(find.byKey(AppKeys.switchCurrencyButton));
  await tester.pumpAndSettle();
}
