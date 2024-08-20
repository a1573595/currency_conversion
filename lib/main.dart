import 'package:currency_conversion/src/ui/l10n/l10n.dart';
import 'package:currency_conversion/src/ui/screen/home_view_model.dart';
import 'package:currency_conversion/src/ui/style/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: CurrencyApp(),
  ));
}

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
          border: OutlineInputBorder(
            borderRadius: WidgetStyle.textFieldRadius,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: WidgetStyle.textFieldRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: WidgetStyle.textFieldRadius,
          ),
        ),
      ),
    );
  }
}

