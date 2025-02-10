import 'package:intl/intl.dart';

class MoneyFormatter {
  // Formate un montant en devise locale française
  static String format(double amount) {
    if (amount.isNaN || amount.isInfinite) {
      return "0,00";
    }

    final format = NumberFormat.currency(locale: "fr_FR", symbol: "€");
    return format.format(amount);
  }
}
