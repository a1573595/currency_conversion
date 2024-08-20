import 'package:intl/intl.dart';

String formatDoubleWithDecimalPlaces(double number, int decimalPlaces) {
  NumberFormat formatter = NumberFormat('#,##0.###')
    ..maximumFractionDigits = decimalPlaces
    ..minimumFractionDigits = decimalPlaces;

  return formatter.format(number);
}
