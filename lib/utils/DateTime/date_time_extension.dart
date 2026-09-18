import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  static String dateFormatConnectionPattern = ' ';

  String toHHMM() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');

    return '$h:$m';
  }

  String toDDMMYYYY(String? connectionPattern) {
    final pattern = connectionPattern ?? dateFormatConnectionPattern;
    return DateFormat('dd MM yyyy').format(this).replaceAll(' ', pattern);
  }

  String toDDMMMYYYY(String? connectionPattern) {
    final pattern = connectionPattern ?? dateFormatConnectionPattern;
    return DateFormat('dd MMM yyyy').format(this).replaceAll(' ', pattern);
  }

  DateTime get dateOnly => DateUtils.dateOnly(this);

  /// Calculates number of weeks for a given year as per https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat('D').format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int weekOfYear() {
    int dayOfYear = int.parse(DateFormat('D').format(this));
    int woy = ((dayOfYear - weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(year - 1);
    } else if (woy > numOfWeeks(year)) {
      woy = 1;
    }
    return woy;
  }
}
