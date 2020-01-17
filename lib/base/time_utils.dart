import 'package:intl/intl.dart';

String formatWithYMMMMEEEEdHms(DateTime date) {
  return DateFormat.yMMMMEEEEd().format(date) +
      " " +
      DateFormat.Hms().format(date);
}
