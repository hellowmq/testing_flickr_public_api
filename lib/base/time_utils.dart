import 'package:intl/intl.dart';

String formatWithYMMMMEEEEdHms(DateTime date) {
  return DateFormat.yMMMMEEEEd().format(date) +
      " " +
      DateFormat.Hms().format(date);
}

class TimeUtils {
  static String formatWithYMMMMEEEEdHms(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date) +
        " " +
        DateFormat.Hms().format(date);
  }
}
