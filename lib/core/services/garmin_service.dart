/// Garmin Connect integration — Phase 2 scaffold.
///
/// Garmin uses OAuth1 (not OAuth2). Full implementation is planned for Phase 2.
/// The UI shows a "Próximamente" (coming soon) state when this service is accessed.
abstract final class GarminService {
  /// Phase 2: OAuth1 authorization URL for Garmin Connect.
  static const String authUrl =
      'https://connect.garmin.com/oauthConfirm';

  /// Whether Garmin integration is available in this release.
  static const bool isAvailable = false;

  /// Returns a placeholder message for the UI.
  static const String comingSoonMessage =
      'La integración con Garmin estará disponible próximamente. '
      'Por ahora, puedes sincronizar tus actividades de Garmin a través de Strava.';
}
