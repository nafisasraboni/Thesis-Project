import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/services/supabase_service.dart';

/// Cloud repository for Supabase database operations.
class SupabaseRepository {
  SupabaseRepository._();

  static final SupabaseRepository _instance = SupabaseRepository._();
  factory SupabaseRepository() => _instance;

  SupabaseClient get _client => SupabaseService().client;

  // ─── Scan History ───────────────────────────────────────

  /// Save a scan result to Supabase cloud.
  Future<void> saveScanHistory({
    required String fileName,
    required String extension,
    required int sizeInBytes,
    required String sha256,
    required String prediction,
    required double confidence,
    required String processingTime,
    required String threatLevel,
    required Map<String, double> probabilities,
    required String assetType,
    DateTime? scanDate,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return; // Skip if not authenticated

    await _client.from('scan_history').insert({
      'user_id': userId,
      'file_name': fileName,
      'extension': extension,
      'size_in_bytes': sizeInBytes,
      'sha256': sha256,
      'prediction': prediction,
      'confidence': confidence,
      'processing_time': processingTime,
      'threat_level': threatLevel,
      'probabilities': jsonEncode(probabilities),
      'asset_type': assetType,
      'scan_date': (scanDate ?? DateTime.now()).toUtc().toIso8601String(),
    });
  }

  /// Fetch scan history for the current user.
  Future<List<Map<String, dynamic>>> getScanHistory({
    String? searchTerm,
    String? filterPrediction,
    int limit = 50,
    int offset = 0,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return [];

    // Apply filters first (on FilterBuilder)
    var query = _client
        .from('scan_history')
        .select()
        .eq('user_id', userId);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      query = query.or(
        'file_name.ilike.%${searchTerm}%,extension.ilike.%${searchTerm}%,sha256.ilike.%${searchTerm}%',
      );
    }

    if (filterPrediction != null && filterPrediction != 'All') {
      query = query.eq('prediction', filterPrediction);
    }

    // Then apply transforms (on TransformBuilder)
    return query
        .order('scan_date', ascending: false)
        .limit(limit)
        .range(offset, offset + limit - 1);
  }

  /// Delete a single scan history entry.
  Future<void> deleteScanHistory(int id) async {
    await _client.from('scan_history').delete().eq('id', id);
  }

  /// Clear all scan history for the current user.
  Future<void> clearScanHistory() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client.from('scan_history').delete().eq('user_id', userId);
  }

  /// Get scan history summary statistics.
  Future<Map<String, dynamic>> getScanSummary() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      return {
        'total_scanned': 0,
        'safe_files': 0,
        'suspicious_files': 0,
        'malware_files': 0,
      };
    }

    final response = await _client
        .from('scan_history')
        .select('prediction')
        .eq('user_id', userId);

    final records = List<Map<String, dynamic>>.from(response);
    return {
      'total_scanned': records.length,
      'safe_files': records.where((r) => r['prediction'] == 'Safe').length,
      'suspicious_files':
          records.where((r) => r['prediction'] == 'Suspicious').length,
      'malware_files':
          records.where((r) => r['prediction'] == 'Malware').length,
    };
  }

  // ─── App Settings ───────────────────────────────────────

  /// Save app settings to Supabase cloud.
  Future<void> saveSettings({
    required bool useMockPrediction,
    required String predictionBaseUrl,
    required int requestTimeoutSeconds,
    required bool saveScanHistory,
    required int analyticsWindowDays,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client.from('app_settings').upsert({
      'user_id': userId,
      'use_mock_prediction': useMockPrediction,
      'prediction_base_url': predictionBaseUrl,
      'request_timeout_seconds': requestTimeoutSeconds,
      'save_scan_history': saveScanHistory,
      'analytics_window_days': analyticsWindowDays,
    });
  }

  /// Load app settings from Supabase cloud.
  Future<Map<String, dynamic>?> getSettings() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await _client
        .from('app_settings')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;

    return Map<String, dynamic>.from(response);
  }

  /// Subscribe to realtime scan history changes.
  Stream<List<Map<String, dynamic>>> watchScanHistory() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return const Stream.empty();

    return _client
        .from('scan_history')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('scan_date', ascending: false);
  }
}