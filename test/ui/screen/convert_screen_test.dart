import 'package:currency_conversion/src/ui/screen/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/test_util.dart';
import '../../source/fake_data_source.dart';

void main() async {
  final list = await FakeDataSource.currencyList;

  group("Convert screen test", () {
    testWidgets("Show currency picker", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          currencyListProvider.overrideWith((ref) => Stream.value(list)),
        ],
        widget: const HomeScreen(),
      ));
      await widgetTester.pump();

      final bnb = find.byType(BottomNavigationBar);
      final bnbItemConvert = find.descendant(of: bnb, matching: find.text("Convert"));
      await widgetTester.tap(bnbItemConvert);
      await widgetTester.pump();

      final inkwell = find.byType(InkWell).first;
      await widgetTester.tap(inkwell);
      await widgetTester.pump();

      final picker = find.byType(CupertinoPicker);
      expect(inkwell, findsOneWidget);
      expect(picker, findsOneWidget);
    });
  });
}
