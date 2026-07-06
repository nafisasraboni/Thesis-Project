import '../entities/app_settings_entity.dart';
import '../repositories/app_settings_repository.dart';

/// Streams the current workspace settings.
class WatchAppSettingsUseCase {
  /// Creates the use case.
  const WatchAppSettingsUseCase(this._repository);

  final AppSettingsRepository _repository;

  Stream<AppSettingsEntity> call() {
    return _repository.watchSettings();
  }
}
