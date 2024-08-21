import 'package:currency_conversion/src/ui/screen/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/test_util.dart';
import '../../source/fake_data_source.dart';

void main() async {
  final list = await FakeDataSource.currencyList;

  group("Currency screen test", () {
    testWidgets("Show listview", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          currencyListProvider.overrideWith((ref) => Stream.value(list)),
        ],
        widget: const HomeScreen(),
      ));
      await widgetTester.pump();

      final listview = find.byType(ListView);
      final listTitle = find.byKey(ValueKey(list.first.code));

      expect(listview, findsOneWidget);
      expect(listTitle, findsOneWidget);
    });
  });
}
