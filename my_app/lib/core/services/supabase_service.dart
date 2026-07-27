import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase backend configuration for the MalGuard application.
abstract final class SupabaseConfig {
  /// Supabase project URL from your project dashboard.
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://awezvaiiyhmysyseraow.supabase.co',
  );

  /// Supabase anonymous key (safe to expose in client code).
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF3ZXp2YWlpeWhteXN5c2VyYW93Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODUxMzc4NDAsImV4cCI6MjEwMDcxMzg0MH0.Bq-NTzWOLUCA5U8fnw_mhKQRIx2nB-15SCtveoqVXXc',
  );
}

/// Service class for Supabase authentication and operations.
class SupabaseService {
  SupabaseService._();

  static final SupabaseService _instance = SupabaseService._();
  factory SupabaseService() => _instance;

  SupabaseClient get client => Supabase.instance.client;

  /// Initialize Supabase with the project credentials.
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
  }

  /// Get the current authenticated user, or null if not signed in.
  User? get currentUser => client.auth.currentUser;

  /// Get the current session, or null if not authenticated.
  Session? get currentSession => client.auth.currentSession;

  /// Sign in with email and password.
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) {
    return client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email and password.
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) {
    return client.auth.signUp(
      email: email,
      password: password,
    );
  }

  /// Sign out the current user.
  Future<void> signOut() {
    return client.auth.signOut();
  }

  /// Listen to authentication state changes.
  Stream<AuthState> get onAuthStateChange => client.auth.onAuthStateChange;

  /// Check if the user is currently authenticated.
  bool get isAuthenticated => currentUser != null;
}