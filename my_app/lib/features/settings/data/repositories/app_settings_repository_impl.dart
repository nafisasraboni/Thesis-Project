import '../../../../data/local/app_database.dart';
import '../../domain/entities/app_settings_entity.dart';
import '../../domain/repositories/app_settings_repository.dart';

/// Drift-backed settings repository implementation.
class AppSettingsRepositoryImpl implements AppSettingsRepository {
  /// Creates a repository implementation.
  const AppSettingsRepositoryImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<AppSettingsEntity> watchSettings() {
    return _database.watchAppSettings();
  }

  @override
  Future<AppSettingsEntity> getSettings() {
    return _database.getAppSettings();
  }

  @override
  Future<void> saveSettings(AppSettingsEntity settings) {
    return _database.saveAppSettings(buildAppSettingsCompanion(settings));
  }

  @override
  Future<void> resetSettings() {
    return saveSettings(AppSettingsEntity.defaults());
  }
}
