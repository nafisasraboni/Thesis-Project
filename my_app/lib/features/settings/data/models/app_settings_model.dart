import '../../domain/entities/app_settings_entity.dart';

/// Concrete model for app settings persistence and mapping.
class AppSettingsModel extends AppSettingsEntity {
  /// Creates a settings model.
  const AppSettingsModel({
    required super.useMockPrediction,
    required super.predictionBaseUrl,
    required super.requestTimeoutSeconds,
    required super.saveScanHistory,
    required super.analyticsWindowDays,
  });

  factory AppSettingsModel.fromEntity(AppSettingsEntity entity) {
    return AppSettingsModel(
      useMockPrediction: entity.useMockPrediction,
      predictionBaseUrl: entity.predictionBaseUrl,
      requestTimeoutSeconds: entity.requestTimeoutSeconds,
      saveScanHistory: entity.saveScanHistory,
      analyticsWindowDays: entity.analyticsWindowDays,
    );
  }

  factory AppSettingsModel.defaults() {
    final defaults = AppSettingsEntity.defaults();
    return AppSettingsModel.fromEntity(defaults);
  }
}
