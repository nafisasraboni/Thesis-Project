import '../../../../core/utils/scan_classification.dart';

/// Domain entity returned after the prediction engine classifies an asset.
class PredictionEntity {
  /// Creates a prediction entity.
  const PredictionEntity({
    required this.prediction,
    required this.confidence,
    required this.processingTime,
    required this.probabilities,
  });

  final String prediction;
  final double confidence;
  final String processingTime;
  final Map<String, double> probabilities;

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

  String get threatLevel {
    switch (classification) {
      case ScanClassification.safe:
        return 'Low';
      case ScanClassification.suspicious:
        return 'Moderate';
      case ScanClassification.malwareDetected:
        return 'Critical';
    }
  }
}
