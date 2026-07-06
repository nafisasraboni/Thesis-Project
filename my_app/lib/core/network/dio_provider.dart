import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/providers/settings_providers.dart';

final dioProvider = Provider<Dio>((ref) {
  final settings = ref.watch(currentAppSettingsProvider);
  final timeout = Duration(seconds: settings.requestTimeoutSeconds);

  return Dio(
    BaseOptions(
      baseUrl: settings.predictionBaseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      headers: const <String, String>{'Accept': 'application/json'},
    ),
  );
});
