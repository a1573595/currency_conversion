import 'package:currency_conversion/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/fake_currency_backend.dart';
import 'support/integration_actions.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("offline currency conversion flow", (tester) async {
    await tester.pumpWidget(
      buildCurrencyApp(
        overrides: fakeApiOverrides(
          responseJson: latestCurrencyJson(
            currencies: {
              "ADA": {"code": "ADA", "value": 2},
              "AFN": {"code": "AFN", "value": 4},
              "USD": {"code": "USD", "value": 8},
              "LOW": {"code": "LOW", "value": 0.009},
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("ADA / TWD"), findsOneWidget);
    expect(find.text("2.00"), findsOneWidget);

    await openConvertTab(tester);
    await enterAmount(tester, "123");
    await selectToCurrencyAtIndex(tester, 1);

    expect(find.text("1 ADA ≈ 2.000000000 AFN"), findsOneWidget);
    expect(find.text("246.000000000 AFN"), findsOneWidget);

    await switchCurrencies(tester);

    expect(find.text("1 AFN ≈ 0.500000000 ADA"), findsOneWidget);
    expect(find.text("61.500000000 ADA"), findsOneWidget);
    expect(find.text("LOW / TWD"), findsNothing);
  });

  testWidgets("offline app pop route shows exit prompt", (tester) async {
    await tester.pumpWidget(
      buildCurrencyApp(
        overrides: fakeApiOverrides(
          responseJson: latestCurrencyJson(
            currencies: {
              "ADA": {"code": "ADA", "value": 2},
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text("Press again to exit"), findsOneWidget);
  });

  testWidgets("offline cached currencies remain visible when refresh fails", (tester) async {
    await tester.pumpWidget(
      buildCurrencyApp(
        overrides: fakeApiOverrides(
          cachedCurrencies: [fakeCurrency("ADA", 2), fakeCurrency("AFN", 4)],
          apiError: DioException(
            requestOptions: RequestOptions(path: "v3/latest?base_currency=TWD"),
            type: DioExceptionType.connectionError,
            error: "offline",
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("ADA / TWD"), findsOneWidget);
    expect(find.text("AFN / TWD"), findsOneWidget);
    expect(find.text("DioException"), findsNothing);
  });
}
