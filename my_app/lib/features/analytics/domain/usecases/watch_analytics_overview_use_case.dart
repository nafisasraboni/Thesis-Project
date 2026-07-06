import '../entities/analytics_overview_entity.dart';
import '../repositories/analytics_repository.dart';

/// Streams the live analytics overview for presentation.
class WatchAnalyticsOverviewUseCase {
  /// Creates the use case.
  const WatchAnalyticsOverviewUseCase(this._repository);

  final AnalyticsRepository _repository;

  Stream<AnalyticsOverviewEntity> call({required int windowDays}) {
    return _repository.watchOverview(windowDays: windowDays);
  }
}
