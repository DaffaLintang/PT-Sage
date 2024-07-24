import 'package:intl/intl.dart';

class Utils {
  static String formatPrice(double price) {
    final format = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return format.format(price);
  }

  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
