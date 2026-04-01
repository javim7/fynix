/// Date utilities for streak calculation and display.
abstract final class DateHelpers {
  /// Returns true if [date] is today (local time).
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Returns true if [date] is yesterday (local time).
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Returns a [DateTime] at midnight local time for the given [date].
  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// Returns the number of full days between two dates (absolute).
  static int daysBetween(DateTime from, DateTime to) {
    final f = startOfDay(from);
    final t = startOfDay(to);
    return t.difference(f).inDays.abs();
  }

  /// Returns true if [lastActivityDate] was yesterday, meaning the streak
  /// is still alive if the user works out today.
  static bool isStreakAlive(DateTime? lastActivityDate) {
    if (lastActivityDate == null) return false;
    return isToday(lastActivityDate) || isYesterday(lastActivityDate);
  }

  /// Formats a [DateTime] as "dd MMM yyyy" (e.g. "15 Mar 2026").
  static String formatDate(DateTime date) {
    const months = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Formats a [DateTime] relative to now: "Hoy", "Ayer", or the date string.
  static String formatRelative(DateTime date) {
    if (isToday(date)) return 'Hoy';
    if (isYesterday(date)) return 'Ayer';
    return formatDate(date);
  }

  /// Returns the Monday of the week containing [date].
  static DateTime weekStart(DateTime date) {
    final d = startOfDay(date);
    final weekday = d.weekday; // 1=Mon, 7=Sun
    return d.subtract(Duration(days: weekday - 1));
  }
}
