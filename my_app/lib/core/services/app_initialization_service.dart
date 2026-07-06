import '../../config/routes/route_names.dart';
import '../constants/app_durations.dart';

/// Coordinates startup work before the user reaches the main workspace.
class AppInitializationService {
  /// Resolves the first route after application bootstrap completes.
  Future<String> resolveInitialRoute() async {
    await Future<void>.delayed(AppDurations.splashDelay);
    return RouteNames.dashboardPath;
  }
}
