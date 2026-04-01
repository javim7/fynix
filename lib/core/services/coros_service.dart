/// COROS integration — Phase 2 scaffold.
///
/// COROS uses OAuth2. Full implementation is planned for Phase 2.
/// The UI shows a "Próximamente" (coming soon) state when this service is accessed.
abstract final class CorosService {
  /// Whether COROS integration is available in this release.
  static const bool isAvailable = false;

  /// Returns a placeholder message for the UI.
  static const String comingSoonMessage =
      'La integración con COROS estará disponible próximamente. '
      'Puedes importar tus actividades COROS exportándolas a Strava.';
}
