import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_conversion/src/common/config.dart';
import 'package:currency_conversion/src/common/string_util.dart';
import 'package:currency_conversion/src/data/repository/currency_repository_impl.dart';
import 'package:currency_conversion/src/domain/model/currency.dart';
import 'package:currency_conversion/src/ui/l10n/l10n.dart';
import 'package:currency_conversion/src/ui/screen/bean/convert_ui_state.dart';
import 'package:currency_conversion/src/ui/style/format_style.dart';
import 'package:currency_conversion/src/ui/style/widget_style.dart';
import 'package:currency_conversion/src/ui/widget/loader_body.dart';
import 'package:currency_conversion/src/ui/widget/picker_sheet.dart';
import 'package:currency_conversion/src/ui/widget/twice_pop_scope.dart';
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'home_screen.dart';

part 'currency_screen.dart';

part 'convert_screen.dart';

final pagePositionProvider = StateProvider.autoDispose<int>((ref) => 0);

final currencyListProvider = StreamProvider.autoDispose<List<Currency>>((ref) {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  return ref.read(currencyRepository).getCurrencyList(cancelToken: cancelToken);
});

final convertUiStateProvider =
    NotifierProvider.autoDispose<ConvertUiStateNotifier, ConvertUiState>(ConvertUiStateNotifier.new);

class ConvertUiStateNotifier extends AutoDisposeNotifier<ConvertUiState> {
  Decimal _amountDecimal = Decimal.fromInt(1);
  Decimal _rateDecimal = Decimal.fromInt(1);

  @override
  ConvertUiState build() {
    ref.listen(currencyListProvider, (previous, next) {
      final list = next.requireValue;
      final fromCurrency = list.firstWhere((e) => e.code == state.fromCurrency.code);
      final toCurrency = list.firstWhere((e) => e.code == state.toCurrency.code);

      _calculateRateDecimal(fromCurrency: fromCurrency, toCurrency: toCurrency);
    });

    final list = ref.read(currencyListProvider.select((value) => value.requireValue));

    return ConvertUiState.byDefault(currency: list.first);
  }

  void updateAmountText(String value) => _calculateResult(amountDecimal: Decimal.tryParse(value));

  void updateFromCurrency(Currency value) => _calculateResult(fromCurrency: value);

  void switchCurrency() => _calculateResult(fromCurrency: state.toCurrency, toCurrency: state.fromCurrency);

  void updateToCurrency(Currency value) => _calculateResult(toCurrency: value);

  void _calculateResult({Decimal? amountDecimal, Currency? fromCurrency, Currency? toCurrency}) {
    _amountDecimal = amountDecimal ?? _amountDecimal;

    if (fromCurrency != null || toCurrency != null) {
      _calculateRateDecimal(fromCurrency: fromCurrency, toCurrency: toCurrency);
    }

    final result = (_amountDecimal * _rateDecimal).toDouble();

    state = state.copyWith(
      amountText: _amountDecimal.toString(),
      fromCurrency: fromCurrency ??= state.fromCurrency,
      toCurrency: toCurrency ??= state.toCurrency,
      rateText: _rateDecimal.toStringAsFixed(Config.amountDecimal),
      resultText: formatDoubleWithDecimalPlaces(result, Config.amountDecimal),
    );
  }

  void _calculateRateDecimal({Currency? fromCurrency, Currency? toCurrency}) {
    fromCurrency ??= state.fromCurrency;
    toCurrency ??= state.toCurrency;

    final fromDecimal = Decimal.fromJson(fromCurrency.twdPrice.toString());
    final toDecimal = Decimal.fromJson(toCurrency.twdPrice.toString());

    _rateDecimal = (fromDecimal / toDecimal).toDecimal(
      scaleOnInfinitePrecision: Config.amountDecimal + Config.amountDecimal,
    );
  }
}
