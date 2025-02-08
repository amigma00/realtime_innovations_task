import 'package:intl/intl.dart';

class HomePageHelper {
  static getFormattedDate(DateTime? date) {
    return date == null ? '' : DateFormat('dd MMM, yyyy').format(date);
  }
}
