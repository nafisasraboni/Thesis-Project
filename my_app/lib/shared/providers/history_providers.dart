import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/app_database.dart';
import '../../features/history/data/repositories/scan_history_repository_impl.dart';
import '../../features/history/data/services/history_export_service.dart';
import '../../features/history/domain/usecases/clear_scan_history_use_case.dart';
import '../../features/history/domain/usecases/delete_scan_history_entry_use_case.dart';
import '../../features/history/domain/usecases/get_scan_history_use_case.dart';
import '../../features/history/domain/usecases/save_scan_history_use_case.dart';
import '../../features/history/domain/usecases/watch_recent_scan_history_use_case.dart';
import '../../features/history/domain/usecases/watch_scan_history_summary_use_case.dart';
import '../../features/history/domain/usecases/watch_scan_history_use_case.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final historyExportServiceProvider = Provider<HistoryExportService>(
  (ref) => const HistoryExportService(),
);

final scanHistoryRepositoryProvider = Provider<ScanHistoryRepositoryImpl>(
  (ref) => ScanHistoryRepositoryImpl(ref.watch(appDatabaseProvider)),
);

final saveScanHistoryUseCaseProvider = Provider<SaveScanHistoryUseCase>(
  (ref) => SaveScanHistoryUseCase(ref.watch(scanHistoryRepositoryProvider)),
);

final watchScanHistoryUseCaseProvider = Provider<WatchScanHistoryUseCase>(
  (ref) => WatchScanHistoryUseCase(ref.watch(scanHistoryRepositoryProvider)),
);

final getScanHistoryUseCaseProvider = Provider<GetScanHistoryUseCase>(
  (ref) => GetScanHistoryUseCase(ref.watch(scanHistoryRepositoryProvider)),
);

final watchRecentScanHistoryUseCaseProvider =
    Provider<WatchRecentScanHistoryUseCase>(
      (ref) => WatchRecentScanHistoryUseCase(
        ref.watch(scanHistoryRepositoryProvider),
      ),
    );

final watchScanHistorySummaryUseCaseProvider =
    Provider<WatchScanHistorySummaryUseCase>(
      (ref) => WatchScanHistorySummaryUseCase(
        ref.watch(scanHistoryRepositoryProvider),
      ),
    );

final deleteScanHistoryEntryUseCaseProvider =
    Provider<DeleteScanHistoryEntryUseCase>(
      (ref) => DeleteScanHistoryEntryUseCase(
        ref.watch(scanHistoryRepositoryProvider),
      ),
    );

final clearScanHistoryUseCaseProvider = Provider<ClearScanHistoryUseCase>(
  (ref) => ClearScanHistoryUseCase(ref.watch(scanHistoryRepositoryProvider)),
);
