import 'package:dio/dio.dart';

import '../../../../core/network/api_config.dart';
import '../../domain/entities/scan_asset_entity.dart';

/// Low-level prediction service responsible for the HTTP contract.
class PredictionService {
  /// Creates a prediction service.
  const PredictionService(this._dio);

  final Dio _dio;

  /// Sends the selected asset to the prediction endpoint.
  Future<Map<String, dynamic>> predict(ScanAssetEntity asset) async {
    if (ApiConfig.useMockPrediction) {
      return _mockResponse(asset);
    }

    final formData = FormData.fromMap(<String, Object?>{
      'file': MultipartFile.fromBytes(asset.bytes, filename: asset.fileName),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      ApiConfig.predictionEndpoint,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return response.data ?? <String, dynamic>{};
  }

  Future<Map<String, dynamic>> _mockResponse(ScanAssetEntity asset) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    final extension = asset.extension.toLowerCase();
    final hashSeed = asset.sha256.codeUnits.fold<int>(
      0,
      (sum, code) => sum + code,
    );

    if (asset.isImage) {
      return _buildResponse(
        prediction: hashSeed.isEven ? 'Suspicious' : 'Safe',
        confidence: hashSeed.isEven ? 88.41 : 93.18,
      );
    }

    if (<String>{'exe', 'dll', 'apk', 'bin'}.contains(extension)) {
      return _buildResponse(
        prediction: hashSeed % 3 == 0 ? 'Malware Detected' : 'Suspicious',
        confidence: hashSeed % 3 == 0 ? 96.42 : 84.77,
      );
    }

    return _buildResponse(
      prediction: hashSeed % 5 == 0 ? 'Suspicious' : 'Safe',
      confidence: hashSeed % 5 == 0 ? 79.24 : 91.63,
    );
  }

  Map<String, dynamic> _buildResponse({
    required String prediction,
    required double confidence,
  }) {
    final normalizedConfidence = confidence.clamp(1, 99.99);
    final malware = prediction == 'Malware Detected'
        ? normalizedConfidence
        : (100 - normalizedConfidence) * 0.18;
    final suspicious = prediction == 'Suspicious'
        ? normalizedConfidence
        : (100 - normalizedConfidence) * 0.34;
    final safe = 100 - malware - suspicious;

    return <String, dynamic>{
      'prediction': prediction,
      'confidence': normalizedConfidence,
      'processing_time': '0.41 sec',
      'probabilities': <String, double>{
        'Safe': double.parse(safe.clamp(0, 100).toStringAsFixed(2)),
        'Suspicious': double.parse(suspicious.clamp(0, 100).toStringAsFixed(2)),
        'Malware': double.parse(malware.clamp(0, 100).toStringAsFixed(2)),
      },
    };
  }
}
