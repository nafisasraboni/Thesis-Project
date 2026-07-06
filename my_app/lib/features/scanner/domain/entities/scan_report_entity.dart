import 'prediction_entity.dart';
import 'scan_asset_entity.dart';

/// Immutable report that combines the uploaded asset with its prediction.
class ScanReportEntity {
  /// Creates a scan report entity.
  const ScanReportEntity({
    required this.asset,
    required this.prediction,
    required this.scanDate,
  });

  final ScanAssetEntity asset;
  final PredictionEntity prediction;
  final DateTime scanDate;
}
