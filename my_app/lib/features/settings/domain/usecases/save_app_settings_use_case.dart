import '../entities/app_settings_entity.dart';
import '../repositories/app_settings_repository.dart';

/// Persists updated workspace settings.
class SaveAppSettingsUseCase {
  /// Creates the use case.
  const SaveAppSettingsUseCase(this._repository);

  final AppSettingsRepository _repository;

  Future<void> call(AppSettingsEntity settings) {
    return _repository.saveSettings(settings);
  }
}
