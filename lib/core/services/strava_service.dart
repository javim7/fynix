import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

part 'strava_service.g.dart';

/// Handles Strava OAuth2 flow and token management.
///
/// OAuth flow:
/// 1. [launchAuthUrl] — opens Strava authorization page
/// 2. Deep link `fynix://strava/callback?code=...` is caught by the app
/// 3. [exchangeCodeForTokens] — exchanges code for access + refresh tokens via Edge Function
@riverpod
StravaService stravaService(Ref ref) => StravaService(ref);

class StravaService {
  StravaService(this._ref);

  final Ref _ref;
  final _dio = Dio();

  String get _clientId => dotenv.env['STRAVA_CLIENT_ID'] ?? '';
  String get _supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  String get _anonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  static const String _redirectUri = 'fynix://strava/callback';
  static const String _scope = 'activity:read_all';

  /// Constructs and launches the Strava OAuth authorization URL.
  Future<void> launchAuthUrl() async {
    final uri = Uri.https('www.strava.com', '/oauth/authorize', {
      'client_id': _clientId,
      'redirect_uri': _redirectUri,
      'response_type': 'code',
      'scope': _scope,
      'approval_prompt': 'auto',
    });

    if (!await canLaunchUrl(uri)) {
      throw Exception('Cannot launch Strava auth URL');
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// Exchanges an authorization code for tokens via the Supabase Edge Function.
  /// The Edge Function stores the tokens securely in the `integrations` table.
  Future<void> exchangeCodeForTokens(String code) async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) throw Exception('User not authenticated');

    try {
      await _dio.post(
        '$_supabaseUrl/functions/v1/strava-oauth-exchange',
        data: {'code': code},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${session.accessToken}',
            'apikey': _anonKey,
            'Content-Type': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      debugPrint('Strava token exchange error: ${e.response?.data}');
      rethrow;
    }
  }

  /// Triggers a manual sync of Strava activities via Edge Function.
  Future<Map<String, dynamic>> triggerSync() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) throw Exception('User not authenticated');

    final response = await _dio.post(
      '$_supabaseUrl/functions/v1/strava-sync',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${session.accessToken}',
          'apikey': _anonKey,
        },
      ),
    );

    return response.data as Map<String, dynamic>;
  }

  /// Disconnects the Strava integration for the current user.
  Future<void> disconnect() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    await Supabase.instance.client
        .from('integrations')
        .update({'is_connected': false, 'access_token': null, 'refresh_token': null})
        .eq('user_id', userId)
        .eq('provider', 'strava');
  }
}
