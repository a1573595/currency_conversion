import 'package:flutter/widgets.dart';

class AppKeys {
  const AppKeys._();

  static const currencyTab = ValueKey<String>('currency_tab');
  static const convertTab = ValueKey<String>('convert_tab');
  static const convertAmountField = ValueKey<String>('convert_amount_field');
  static const fromCurrencyCard = ValueKey<String>('from_currency_card');
  static const toCurrencyCard = ValueKey<String>('to_currency_card');
  static const switchCurrencyButton = ValueKey<String>('switch_currency_button');
  static const currencyPicker = ValueKey<String>('currency_picker');
  static const pickerSave = ValueKey<String>('picker_save');
  static const pickerCancel = ValueKey<String>('picker_cancel');
  static const convertRateText = ValueKey<String>('convert_rate_text');
  static const convertResultText = ValueKey<String>('convert_result_text');

  static ValueKey<String> currencyPickerItem(String code) => ValueKey<String>('currency_picker_item_$code');
}
