import 'package:intl/intl.dart';

class SelectDateDialogHelper {
  static DateTime getNextMonday() {
    DateTime today = DateTime.now();
    int daysUntilMonday = (DateTime.monday - today.weekday + 7) % 7;
    daysUntilMonday = daysUntilMonday == 0
        ? 7
        : daysUntilMonday; // If today is Monday, get next Monday
    return today.add(Duration(days: daysUntilMonday));
  }

  static DateTime getNextTuesday() {
    DateTime today = DateTime.now();
    int daysUntilTuesday = (DateTime.tuesday - today.weekday + 7) % 7;
    daysUntilTuesday = daysUntilTuesday == 0
        ? 7
        : daysUntilTuesday; // If today is Monday, get next Monday
    return today.add(Duration(days: daysUntilTuesday));
  }

  static DateTime getDateAfterOneWeek() {
    DateTime today = DateTime.now();
    return today.add(Duration(days: 7));
  }

  static String getFormattedDate(DateTime? date) {
    var now = DateTime.now();

    return date == null
        ? 'No date'
        : DateTime(
                  date.year,
                  date.month,
                  date.day,
                ) ==
                DateTime(
                  now.year,
                  now.month,
                  now.day,
                )
            ? 'Today'
            : DateFormat('dd MMM yyyy').format(date);
  }
}
