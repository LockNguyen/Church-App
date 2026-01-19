/// Utility for formatting dates and times in Vietnamese style.
class TimeFormatter {
  /// Format day of week in Vietnamese (T2, T3, T4, T5, T6, T7, CN)
  static String getVietnameseDayOfWeek(DateTime dateTime) {
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
  
  /// Format class time range (T6, 6:00pm - 7:00pm)
  static String formatClassTimeRange(DateTime startTime, DateTime endTime) {
    final dayOfWeek = getVietnameseDayOfWeek(startTime);
    final startTimeStr = formatTime12Hour(startTime);
    final endTimeStr = formatTime12Hour(endTime);
    
    return '$dayOfWeek, $startTimeStr – $endTimeStr';
  }
}