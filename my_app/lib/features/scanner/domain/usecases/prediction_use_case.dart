import '../entities/prediction_entity.dart';
import '../entities/scan_asset_entity.dart';
import '../repositories/prediction_repository.dart';

/// Use case that encapsulates the malware prediction operation.
class PredictionUseCase {
  /// Creates a prediction use case.
  const PredictionUseCase(this._repository);

  final PredictionRepository _repository;

  /// Executes the prediction workflow for the selected asset.
  Future<PredictionEntity> call(ScanAssetEntity asset) {
    return _repository.predict(asset);
  }
}
