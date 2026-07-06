import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/settings_providers.dart';
import '../../domain/entities/app_settings_entity.dart';

final settingsMutationControllerProvider =
    AsyncNotifierProvider<SettingsMutationController, void>(
      SettingsMutationController.new,
    );

/// Handles settings save and reset mutations.
class SettingsMutationController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> saveSettings(AppSettingsEntity settings) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(
      () => ref.read(saveAppSettingsUseCaseProvider)(settings),
    );
  }

  Future<void> resetSettings() async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(
      () => ref.read(resetAppSettingsUseCaseProvider)(),
    );
  }
}
