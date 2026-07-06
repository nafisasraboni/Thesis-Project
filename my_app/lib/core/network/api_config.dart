/// Runtime API configuration for prediction requests.
abstract final class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'PREDICTION_API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000',
  );

  static const bool useMockPrediction = bool.fromEnvironment(
    'USE_MOCK_PREDICTION',
    defaultValue: true,
  );

  static const String predictionEndpoint = '/api/predict';
}
