/// Formatting utilities for pace values.
abstract final class PaceFormatter {
  /// Converts pace in seconds per km to a "mm:ss /km" string.
  /// Example: 330 → "5:30 /km"
  static String format(double secondsPerKm) {
    final totalSeconds = secondsPerKm.round();
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes}:${seconds.toString().padLeft(2, '0')} /km';
  }

  /// Converts pace in seconds per km to a "mm:ss" string (no unit).
  static String formatShort(double secondsPerKm) {
    final totalSeconds = secondsPerKm.round();
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Formats a duration in seconds to "h:mm:ss" or "mm:ss".
  static String formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    if (hours > 0) {
      return '${hours}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Formats duration as "Xh Ym" for display (e.g. "1h 30m", "45m").
  static String formatDurationHuman(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    if (hours > 0 && minutes > 0) return '${hours}h ${minutes}m';
    if (hours > 0) return '${hours}h';
    return '${minutes}m';
  }

  /// Speed in km/h to "X.X km/h" string.
  static String formatSpeed(double kmh) =>
      '${kmh.toStringAsFixed(1)} km/h';
}
