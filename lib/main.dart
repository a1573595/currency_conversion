import 'package:currency_conversion/common/l10n/l10n.dart';
import 'package:currency_conversion/data/local/object_box_help.dart';
import 'package:currency_conversion/ui/screen/home_view_model.dart';
import 'package:currency_conversion/ui/style/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ObjectBoxHelp.init();

  runApp(buildCurrencyApp());
}

Widget buildCurrencyApp({List<Override> overrides = const []}) =>
    ProviderScope(retry: (retryCount, error) => null, overrides: overrides, child: const CurrencyApp());

class CurrencyApp extends StatelessWidget {
  const CurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Conversion",
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      home: const HomeScreen(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: WidgetStyle.textFieldRadius),
          disabledBorder: OutlineInputBorder(borderRadius: WidgetStyle.textFieldRadius),
          enabledBorder: OutlineInputBorder(borderRadius: WidgetStyle.textFieldRadius),
        ),
      ),
    );
  }
}
