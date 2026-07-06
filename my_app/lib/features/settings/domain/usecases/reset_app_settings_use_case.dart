import '../repositories/app_settings_repository.dart';

/// Restores the workspace settings to their defaults.
class ResetAppSettingsUseCase {
  /// Creates the use case.
  const ResetAppSettingsUseCase(this._repository);

  final AppSettingsRepository _repository;

  Future<void> call() {
    return _repository.resetSettings();
  }
}
