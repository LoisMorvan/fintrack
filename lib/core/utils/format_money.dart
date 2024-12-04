import 'package:intl/intl.dart';

String formatMoney(double amount) {
  final format = NumberFormat("#,##0.00", "fr_FR");
  String formattedAmount = format.format(amount);
  return formattedAmount;
}
