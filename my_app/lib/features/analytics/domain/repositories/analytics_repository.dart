import '../entities/analytics_overview_entity.dart';

/// Repository abstraction for analytics derived from scan history.
abstract class AnalyticsRepository {
  /// Watches the live analytics overview for the selected time window.
  Stream<AnalyticsOverviewEntity> watchOverview({required int windowDays});
}
