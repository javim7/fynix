/// Formatting utilities for distance values.
abstract final class DistanceFormatter {
  /// Converts meters to a human-readable km string.
  /// Example: 10400 → "10.4 km"
  static String formatKm(double meters) {
    final km = meters / 1000.0;
    if (km >= 100) return '${km.round()} km';
    if (km >= 10) return '${km.toStringAsFixed(1)} km';
    return '${km.toStringAsFixed(2)} km';
  }

  /// Converts meters to kilometers as a double.
  static double toKm(double meters) => meters / 1000.0;

  /// Converts meters to miles as a double.
  static double toMiles(double meters) => meters / 1609.344;

  /// Formats meters to "X.XX mi".
  static String formatMiles(double meters) {
    final miles = toMiles(meters);
    return '${miles.toStringAsFixed(2)} mi';
  }

  /// Compact format — always shows the value without unit suffix for tight layouts.
  /// Returns the raw number string with appropriate precision.
  static String formatCompact(double meters) {
    final km = meters / 1000.0;
    if (km >= 100) return km.round().toString();
    if (km >= 10) return km.toStringAsFixed(1);
    return km.toStringAsFixed(2);
  }

  /// Elevation in meters to "Xm" or "X.Xm".
  static String formatElevation(double meters) {
    if (meters >= 100) return '${meters.round()}m';
    return '${meters.toStringAsFixed(1)}m';
  }
}
