import 'dart:convert';

import '../../../../data/local/app_database.dart';
import '../../domain/entities/scan_history_record_entity.dart';
import '../../../scanner/domain/entities/scan_asset_entity.dart';

/// Database-backed history record model.
class ScanHistoryRecordModel extends ScanHistoryRecordEntity {
  /// Creates a history record model.
  const ScanHistoryRecordModel({
    required super.id,
    required super.fileName,
    required super.extension,
    required super.sizeInBytes,
    required super.sha256,
    required super.prediction,
    required super.confidence,
    required super.processingTime,
    required super.probabilities,
    required super.assetType,
    required super.scanDate,
  });

  /// Maps a generated Drift row into a history model.
  factory ScanHistoryRecordModel.fromData(ScanHistoryEntry row) {
    final decodedProbabilities =
        (jsonDecode(row.probabilitiesJson) as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        );

    return ScanHistoryRecordModel(
      id: row.id,
      fileName: row.fileName,
      extension: row.extension,
      sizeInBytes: row.sizeInBytes,
      sha256: row.sha256,
      prediction: row.prediction,
      confidence: row.confidence,
      processingTime: row.processingTime,
      probabilities: decodedProbabilities,
      assetType: row.assetType == 'image'
          ? ScanAssetType.image
          : ScanAssetType.file,
      scanDate: row.scanDate,
    );
  }
}
