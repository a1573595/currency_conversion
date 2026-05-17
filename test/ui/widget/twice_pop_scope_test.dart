import 'package:currency_conversion/common/l10n/app_localizations.dart';
import 'package:currency_conversion/common/l10n/l10n.dart';
import 'package:currency_conversion/ui/widget/twice_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      "/": (context) => const SizedBox(),
      "/second": (context) => TwicePopScope(
        child: Scaffold(appBar: AppBar(leading: const BackButton())),
      ),
    },
  );

  group("Twice pop scope test", () {
    testWidgets("Show exit prompt", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget());

      NavigatorState navigator = widgetTester.state(find.byType(Navigator));

      expect(navigator.canPop(), false);

      navigator.pushNamed("/second");
      await widgetTester.pumpAndSettle();

      expect(navigator.canPop(), true);

      await navigator.maybePop();
      await widgetTester.pump();

      final snackbar = find.byType(SnackBar);
      expect(snackbar, findsOneWidget);
    });

    testWidgets("Requests system exit", (widgetTester) async {
      var exitRequested = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (methodCall) async {
          if (methodCall.method == "SystemNavigator.pop") {
            exitRequested = true;
          }
          return null;
        },
      );
      addTearDown(
        () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );

      await widgetTester.pumpWidget(buildTestWidget());

      NavigatorState navigator = widgetTester.state(find.byType(Navigator));

      expect(navigator.canPop(), false);

      navigator.pushNamed("/second");
      await widgetTester.pumpAndSettle();

      expect(navigator.canPop(), true);

      await navigator.maybePop();
      await navigator.maybePop();
      await widgetTester.pumpAndSettle();

      expect(exitRequested, true);
    });

    testWidgets("Shows prompt again when second pop is after timeout", (widgetTester) async {
      var exitRequested = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (methodCall) async {
          if (methodCall.method == "SystemNavigator.pop") {
            exitRequested = true;
          }
          return null;
        },
      );
      addTearDown(
        () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );

      var now = DateTime(2026, 5, 11);
      await widgetTester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) {
            final appLocalizations = AppLocalizations.of(context)!;
            L10n.init(appLocalizations);

            return Material(child: child);
          },
          home: TwicePopScope(now: () => now, child: const Scaffold()),
        ),
      );

      final navigator = Navigator.of(widgetTester.element(find.byType(TwicePopScope)));

      await navigator.maybePop();
      await widgetTester.pump();
      now = now.add(const Duration(seconds: 3));
      await navigator.maybePop();
      await widgetTester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(exitRequested, false);
    });
  });
}
