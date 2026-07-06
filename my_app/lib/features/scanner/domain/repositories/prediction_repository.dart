import '../entities/prediction_entity.dart';
import '../entities/scan_asset_entity.dart';

/// Repository abstraction for prediction requests.
abstract class PredictionRepository {
  /// Sends the selected asset for classification.
  Future<PredictionEntity> predict(ScanAssetEntity asset);
}
