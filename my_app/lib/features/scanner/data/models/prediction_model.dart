import '../../domain/entities/prediction_entity.dart';

/// Concrete response model returned by the prediction endpoint.
class PredictionModel extends PredictionEntity {
  /// Creates a prediction model.
  const PredictionModel({
    required super.prediction,
    required super.confidence,
    required super.processingTime,
    required super.probabilities,
  });

  /// Creates a prediction model from the backend response payload.
  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    final rawProbabilities =
        (json['probabilities'] as Map<String, dynamic>? ?? <String, dynamic>{})
            .map(
              (key, value) => MapEntry(key, (value as num?)?.toDouble() ?? 0),
            );

    return PredictionModel(
      prediction: (json['prediction'] as String?)?.trim().isNotEmpty == true
          ? json['prediction'] as String
          : 'Suspicious',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
      processingTime: (json['processing_time'] as String?) ?? '--',
      probabilities: rawProbabilities,
    );
  }
}
