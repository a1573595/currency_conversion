import 'package:currency_conversion/src/ui/l10n/l10n.dart';
import 'package:currency_conversion/src/ui/widget/twice_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestWidget() => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) {
          final appLocalizations = AppLocalizations.of(context)!;
          L10n.init(appLocalizations);

          return Material(child: child);
        },
        routes: {
          '/': (context) => const SizedBox(),
          '/second': (context) => TwicePopScope(
                child: Scaffold(
                  appBar: AppBar(
                    leading: const BackButton(),
                  ),
                ),
              ),
        },
      );

  group("Twice pop scope test", () {
    testWidgets("Show exit prompt", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget());

      NavigatorState navigator = widgetTester.state(find.byType(Navigator));

      expect(navigator.canPop(), false);

      navigator.pushNamed('/second');
      await widgetTester.pumpAndSettle();

      expect(navigator.canPop(), true);

      navigator.pop();
      await widgetTester.pump();

      final snackbar = find.byType(SnackBar);
      expect(snackbar, findsOneWidget);
    });

    testWidgets("Exit app", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget());

      NavigatorState navigator = widgetTester.state(find.byType(Navigator));

      expect(navigator.canPop(), false);

      navigator.pushNamed('/second');
      await widgetTester.pumpAndSettle();

      expect(navigator.canPop(), true);

      navigator.pop();
      navigator.pop();
      await widgetTester.pumpAndSettle();

      expect(navigator.canPop(), false);
    });
  });
}
