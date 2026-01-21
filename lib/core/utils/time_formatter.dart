import 'package:intl/intl.dart';

/// Utility for formatting dates and times based on locale.
class TimeFormatter {
  /// Format day of week based on locale
  /// Vietnamese: T2, T3, T4, T5, T6, T7, CN
  /// English: Mon, Tue, Wed, Thu, Fri, Sat, Sun
  static String getDayOfWeek(DateTime dateTime, String localeCode) {
    if (localeCode == 'vi') {
      switch (dateTime.weekday) {
        case DateTime.monday:
          return 'T2';
        case DateTime.tuesday:
          return 'T3';
        case DateTime.wednesday:
          return 'T4';
        case DateTime.thursday:
          return 'T5';
        case DateTime.friday:
          return 'T6';
        case DateTime.saturday:
          return 'T7';
        case DateTime.sunday:
          return 'CN';
        default:
          return '';
      }
    } else {
      return DateFormat.E(localeCode).format(dateTime);
    }
  }

  /// Format time in 12-hour format (6:00pm)
  static String formatTime12Hour(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'pm' : 'am';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final minuteStr = minute.toString().padLeft(2, '0');

    return '$displayHour:$minuteStr$period';
  }

  /// Format class time range with locale-aware day of week
  /// Example: T6, 6:00pm – 7:00pm (Vietnamese) or Fri, 6:00pm – 7:00pm (English)
  static String formatClassTimeRange(
      DateTime startTime, DateTime endTime, String localeCode) {
    final dayOfWeek = getDayOfWeek(startTime, localeCode);
    final startTimeStr = formatTime12Hour(startTime);
    final endTimeStr = formatTime12Hour(endTime);

    return '$dayOfWeek, $startTimeStr – $endTimeStr';
  }

  /// Format date in locale-specific format
  /// Vietnamese: 15 tháng 1, 2026
  /// English: January 15, 2026
  static String formatDate(DateTime dateTime, String localeCode) {
    return DateFormat.yMMMMd(localeCode).format(dateTime);
  }

  /// Format short date in locale-specific format
  /// Vietnamese: 15/01/2026
  /// English: 1/15/2026
  static String formatShortDate(DateTime dateTime, String localeCode) {
    return DateFormat.yMd(localeCode).format(dateTime);
  }
}
