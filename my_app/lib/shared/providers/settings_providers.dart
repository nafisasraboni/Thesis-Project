import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/data/repositories/app_settings_repository_impl.dart';
import '../../features/settings/domain/entities/app_settings_entity.dart';
import '../../features/settings/domain/usecases/get_app_settings_use_case.dart';
import '../../features/settings/domain/usecases/reset_app_settings_use_case.dart';
import '../../features/settings/domain/usecases/save_app_settings_use_case.dart';
import '../../features/settings/domain/usecases/watch_app_settings_use_case.dart';
import 'history_providers.dart';

final appSettingsRepositoryProvider = Provider<AppSettingsRepositoryImpl>(
  (ref) => AppSettingsRepositoryImpl(ref.watch(appDatabaseProvider)),
);

final getAppSettingsUseCaseProvider = Provider<GetAppSettingsUseCase>(
  (ref) => GetAppSettingsUseCase(ref.watch(appSettingsRepositoryProvider)),
);

final watchAppSettingsUseCaseProvider = Provider<WatchAppSettingsUseCase>(
  (ref) => WatchAppSettingsUseCase(ref.watch(appSettingsRepositoryProvider)),
);

final saveAppSettingsUseCaseProvider = Provider<SaveAppSettingsUseCase>(
  (ref) => SaveAppSettingsUseCase(ref.watch(appSettingsRepositoryProvider)),
);

final resetAppSettingsUseCaseProvider = Provider<ResetAppSettingsUseCase>(
  (ref) => ResetAppSettingsUseCase(ref.watch(appSettingsRepositoryProvider)),
);

final appSettingsProvider = StreamProvider<AppSettingsEntity>((ref) {
  return ref.watch(watchAppSettingsUseCaseProvider)();
});

final currentAppSettingsProvider = Provider<AppSettingsEntity>((ref) {
  final settingsAsync = ref.watch(appSettingsProvider);
  return settingsAsync.maybeWhen(
    data: (settings) => settings,
    orElse: AppSettingsEntity.defaults,
  );
});
