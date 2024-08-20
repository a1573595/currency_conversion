import 'package:currency_conversion/src/common/config.dart';
import 'package:currency_conversion/src/common/string_util.dart';
import 'package:currency_conversion/src/domain/model/currency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'convert_ui_state.freezed.dart';

@Freezed(equal: false)
class ConvertUiState with _$ConvertUiState, EquatableMixin {
  const ConvertUiState._();

  const factory ConvertUiState({
    required String amountText,
    required Currency fromCurrency,
    required Currency toCurrency,
    required String rateText,
    required String resultText,
  }) = _ConvertUiState;

  factory ConvertUiState.byDefault({required Currency currency}) => ConvertUiState(
        amountText: "1",
        fromCurrency: currency,
        toCurrency: currency,
        rateText: 1.0.toStringAsFixed(Config.amountDecimal),
        resultText: formatDoubleWithDecimalPlaces(1, Config.amountDecimal),
      );

  @override
  List<Object?> get props => [
        amountText,
        fromCurrency,
        toCurrency,
        rateText,
        resultText,
      ];
}
