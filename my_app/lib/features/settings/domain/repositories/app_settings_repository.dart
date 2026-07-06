import '../entities/app_settings_entity.dart';

/// Repository abstraction for persisted workspace settings.
abstract class AppSettingsRepository {
  /// Watches the current application settings.
  Stream<AppSettingsEntity> watchSettings();

  /// Loads the current application settings.
  Future<AppSettingsEntity> getSettings();

  /// Persists updated application settings.
  Future<void> saveSettings(AppSettingsEntity settings);

  /// Restores default application settings.
  Future<void> resetSettings();
}
