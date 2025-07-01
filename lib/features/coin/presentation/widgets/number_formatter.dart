import 'package:intl/intl.dart';

String formatNumber(num? value, {int fractionDigits = 2}) {
  if (value == null) return fractionDigits == 0 ? '0' : '0.00';
  
  final formatter = NumberFormat("#,##0${fractionDigits > 0 ? '.${'0' * fractionDigits}' : ''}", "en_US");
  final formatted = formatter.format(value);
  
  if (fractionDigits > 0 && value == value.roundToDouble()) {
    return formatted.replaceAll(RegExp(r'\.0+$'), '');
  }
  return formatted;
}