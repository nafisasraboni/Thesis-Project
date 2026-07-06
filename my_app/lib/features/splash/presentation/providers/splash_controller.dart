import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/app_initialization_service.dart';

final appInitializationServiceProvider = Provider<AppInitializationService>(
  (ref) => AppInitializationService(),
);

/// Loads startup requirements before the user is routed into the app shell.
final splashControllerProvider = FutureProvider<String>((ref) async {
  final initializationService = ref.watch(appInitializationServiceProvider);
  return initializationService.resolveInitialRoute();
});
