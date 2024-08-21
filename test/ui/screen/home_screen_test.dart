import 'package:currency_conversion/src/ui/screen/home_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/test_util.dart';
import '../../source/fake_data_source.dart';

void main() async {
  final list = await FakeDataSource.currencyList;

  group("Home screen test", () {
    testWidgets("Loading data", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          currencyListProvider.overrideWith((ref) => const Stream.empty()),
        ],
        widget: const HomeScreen(),
      ));

      final circularProgressIndicator =
      find.descendant(of: find.byType(Center), matching: find.byType(CircularProgressIndicator));
      expect(circularProgressIndicator, findsOneWidget);
    });

    testWidgets("Load data failed", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          currencyListProvider.overrideWith((ref) => Stream.fromFuture(Future.delayed(Duration.zero))),
        ],
        widget: const HomeScreen(),
      ));

      final errorText = find.descendant(of: find.byType(Center), matching: find.byType(Text));
      expect(errorText, findsOneWidget);
    });

    testWidgets("BottomNavigationBar change page", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          currencyListProvider.overrideWith((ref) => Stream.value(list)),
        ],
        widget: const HomeScreen(),
      ));
      await widgetTester.pump();

      final bnb = find.byType(BottomNavigationBar);
      final bnbItemCurrency = find.descendant(of: bnb, matching: find.text("Currency"));
      final bnbItemConvert = find.descendant(of: bnb, matching: find.text("Convert"));

      expect(bnb, findsOneWidget);
      expect(bnbItemCurrency, findsOneWidget);
      expect(bnbItemConvert, findsOneWidget);
      expect(find.byType(CurrencyScreen), findsOneWidget);
      expect(find.byType(ConvertScreen), findsNothing);

      await widgetTester.tap(bnbItemConvert);
      await widgetTester.pump();

      expect(find.byType(CurrencyScreen), findsNothing);
      expect(find.byType(ConvertScreen), findsOneWidget);
    });

    testWidgets("BottomNavigationBar change to second page", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          currencyListProvider.overrideWith((ref) => Stream.value(list)),
        ],
        widget: const HomeScreen(),
      ));
      await widgetTester.pump();

      final bnb = find.byType(BottomNavigationBar);
      final bnbItemConvert = find.descendant(of: bnb, matching: find.text("Convert"));

      final element = widgetTester.element(find.byType(HomeScreen));
      final container = ProviderScope.containerOf(element);

      await widgetTester.tap(bnbItemConvert);
      await widgetTester.pump();

      expect(container.read(pagePositionProvider.notifier).state, 1);
    });
  });
}
