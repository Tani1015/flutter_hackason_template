import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  SupabaseHelper._();

  static SupabaseHelper get instance => _instance;
  static final _instance = SupabaseHelper._();

  static Future<Supabase> init({
    required String url,
    required String anonKey,
  }) async {
    return await Supabase.initialize(url: url, anonKey: anonKey);
  }
}
