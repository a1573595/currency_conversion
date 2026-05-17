import 'package:currency_conversion/domain/model/currency.dart';
import 'package:currency_conversion/ui/screen/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/test_util.dart';

void main() async {
  final list = List.generate(30, (index) => _currency("A${index.toString().padLeft(2, "0")}", index + 0.25));

  group("Currency screen test", () {
    testWidgets("Show listview", (widgetTester) async {
      await widgetTester.pumpWidget(
        buildTestWidget(
          overrides: [currencyListProvider.overrideWith((ref) => Stream.value(list))],
          widget: const HomeScreen(),
        ),
      );
      await widgetTester.pump();

      final listview = find.byType(ListView);
      final listTitle = find.byKey(ValueKey(list.first.code));

      expect(listview, findsOneWidget);
      expect(listTitle, findsOneWidget);
      expect(find.text("A00 / TWD"), findsOneWidget);
      expect(find.text("0.25"), findsOneWidget);
    });

    testWidgets("Scroll to off-screen currency", (widgetTester) async {
      await widgetTester.pumpWidget(
        buildTestWidget(
          overrides: [currencyListProvider.overrideWith((ref) => Stream.value(list))],
          widget: const HomeScreen(),
        ),
      );
      await widgetTester.pump();

      await widgetTester.dragUntilVisible(
        find.byKey(ValueKey(list.last.code)),
        find.byType(ListView),
        const Offset(0, -400),
      );

      expect(find.text("A29 / TWD"), findsOneWidget);
      expect(find.text("29.25"), findsOneWidget);
    });
  });
}

Currency _currency(String code, double twdPrice) => Currency(code: code, flagImage: "", twdPrice: twdPrice);
