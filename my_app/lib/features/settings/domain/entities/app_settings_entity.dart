import '../../../../core/constants/app_limits.dart';
import '../../../../core/network/api_config.dart';

/// Persisted runtime configuration used by prediction and analytics flows.
class AppSettingsEntity {
  /// Creates an application settings entity.
  const AppSettingsEntity({
    required this.useMockPrediction,
    required this.predictionBaseUrl,
    required this.requestTimeoutSeconds,
    required this.saveScanHistory,
    required this.analyticsWindowDays,
  });

  final bool useMockPrediction;
  final String predictionBaseUrl;
  final int requestTimeoutSeconds;
  final bool saveScanHistory;
  final int analyticsWindowDays;

  int get maxUploadSizeMb => AppLimits.maxUploadBytes ~/ (1024 * 1024);

  static const List<int> supportedTimeouts = <int>[15, 30, 45, 60];
  static const List<int> supportedAnalyticsWindows = <int>[7, 14, 30];

  factory AppSettingsEntity.defaults() {
    return const AppSettingsEntity(
      useMockPrediction: ApiConfig.defaultUseMockPrediction,
      predictionBaseUrl: ApiConfig.defaultBaseUrl,
      requestTimeoutSeconds: ApiConfig.defaultRequestTimeoutSeconds,
      saveScanHistory: true,
      analyticsWindowDays: ApiConfig.defaultAnalyticsWindowDays,
    );
  }

  AppSettingsEntity copyWith({
    bool? useMockPrediction,
    String? predictionBaseUrl,
    int? requestTimeoutSeconds,
    bool? saveScanHistory,
    int? analyticsWindowDays,
  }) {
    return AppSettingsEntity(
      useMockPrediction: useMockPrediction ?? this.useMockPrediction,
      predictionBaseUrl: predictionBaseUrl ?? this.predictionBaseUrl,
      requestTimeoutSeconds:
          requestTimeoutSeconds ?? this.requestTimeoutSeconds,
      saveScanHistory: saveScanHistory ?? this.saveScanHistory,
      analyticsWindowDays: analyticsWindowDays ?? this.analyticsWindowDays,
    );
  }
}
