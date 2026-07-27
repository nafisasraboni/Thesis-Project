/// Runtime API configuration for prediction requests.
abstract final class ApiConfig {
  static const String defaultBaseUrl = String.fromEnvironment(
    'PREDICTION_API_BASE_URL',
    defaultValue: 'https://bi-lstmcnn-production.up.railway.app',
  );

  static const bool defaultUseMockPrediction = bool.fromEnvironment(
    'USE_MOCK_PREDICTION',
    defaultValue: true,
  );

  static const int defaultRequestTimeoutSeconds = int.fromEnvironment(
    'PREDICTION_REQUEST_TIMEOUT_SECONDS',
    defaultValue: 30,
  );

  static const int defaultAnalyticsWindowDays = int.fromEnvironment(
    'ANALYTICS_WINDOW_DAYS',
    defaultValue: 7,
  );

  static const String predictionEndpoint = '/api/predict';
}
