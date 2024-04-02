import 'dart:math';
import 'package:intl/intl.dart';

class AppFunction {
  static String generateRandomString(int len) {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  static String getFormattedDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final noTimeDate = DateTime(date.year, date.month, date.day);
    String formattedDate = today.difference(noTimeDate).inDays == 0
        ? "Today"
        : yesterday.difference(noTimeDate).inDays == 0
            ? "Yesterday"
            : DateFormat("MM/dd/yyyy").format(noTimeDate);
    return formattedDate;
  }
}
