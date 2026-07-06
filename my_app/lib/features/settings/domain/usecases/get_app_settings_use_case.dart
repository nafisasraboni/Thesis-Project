import '../entities/app_settings_entity.dart';
import '../repositories/app_settings_repository.dart';

/// Loads the current persisted workspace settings.
class GetAppSettingsUseCase {
  /// Creates the use case.
  const GetAppSettingsUseCase(this._repository);

  final AppSettingsRepository _repository;

  Future<AppSettingsEntity> call() {
    return _repository.getSettings();
  }
}
