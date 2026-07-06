import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/history_providers.dart';
import '../../../../shared/providers/settings_providers.dart';
import '../../data/repositories/analytics_repository_impl.dart';
import '../../domain/entities/analytics_overview_entity.dart';
import '../../domain/usecases/watch_analytics_overview_use_case.dart';

final analyticsRepositoryProvider = Provider<AnalyticsRepositoryImpl>(
  (ref) => AnalyticsRepositoryImpl(ref.watch(scanHistoryRepositoryProvider)),
);

final watchAnalyticsOverviewUseCaseProvider =
    Provider<WatchAnalyticsOverviewUseCase>(
      (ref) =>
          WatchAnalyticsOverviewUseCase(ref.watch(analyticsRepositoryProvider)),
    );

final analyticsOverviewProvider = StreamProvider<AnalyticsOverviewEntity>((
  ref,
) {
  final settings = ref.watch(currentAppSettingsProvider);
  return ref
      .watch(watchAnalyticsOverviewUseCaseProvider)
      .call(windowDays: settings.analyticsWindowDays);
});
