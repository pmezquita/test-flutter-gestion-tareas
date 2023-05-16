import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  if (date == null) return '';
  return DateFormat('dd-MM-yyyy').format(date);
}

DateTime dateFromStr(String date) {
  return DateFormat('dd-MM-yyyy').parse(date);
}
