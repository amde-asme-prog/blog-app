import 'package:intl/intl.dart';

String formatDateByDDMMYYYY(DateTime date) {
  return DateFormat('dd MMM, yyyy').format(date);
}
