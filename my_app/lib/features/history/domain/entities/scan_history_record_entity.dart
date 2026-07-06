import 'dart:typed_data';

import '../../../../core/utils/scan_classification.dart';
import '../../../scanner/domain/entities/prediction_entity.dart';
import '../../../scanner/domain/entities/scan_asset_entity.dart';
import '../../../scanner/domain/entities/scan_report_entity.dart';

/// Persisted scan history record stored in the local database.
class ScanHistoryRecordEntity {
  /// Creates a history record.
  const ScanHistoryRecordEntity({
    required this.id,
    required this.fileName,
    required this.extension,
    required this.sizeInBytes,
    required this.sha256,
    required this.prediction,
    required this.confidence,
    required this.processingTime,
    required this.probabilities,
    required this.assetType,
    required this.scanDate,
  });

  final int id;
  final String fileName;
  final String extension;
  final int sizeInBytes;
  final String sha256;
  final String prediction;
  final double confidence;
  final String processingTime;
  final Map<String, double> probabilities;
  final ScanAssetType assetType;
  final DateTime scanDate;

  ScanClassification get classification {
    switch (prediction.toLowerCase()) {
      case 'safe':
        return ScanClassification.safe;
      case 'suspicious':
        return ScanClassification.suspicious;
      default:
        return ScanClassification.malwareDetected;
    }
  }

  ScanReportEntity toScanReport() {
    return ScanReportEntity(
      asset: ScanAssetEntity(
        fileName: fileName,
        extension: extension,
        sizeInBytes: sizeInBytes,
        sha256: sha256,
        bytes: Uint8List(0),
        assetType: assetType,
      ),
      prediction: PredictionEntity(
        prediction: prediction,
        confidence: confidence,
        processingTime: processingTime,
        probabilities: probabilities,
      ),
      scanDate: scanDate,
    );
  }
}
