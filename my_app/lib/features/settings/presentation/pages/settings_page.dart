import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/scan_classification.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/providers/settings_providers.dart';
import '../../domain/entities/app_settings_entity.dart';
import '../providers/settings_mutation_controller.dart';

/// Settings page for workspace options and project access links.
class SettingsPage extends ConsumerStatefulWidget {
  /// Creates the settings page.
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late final TextEditingController _endpointController;
  AppSettingsEntity? _loadedSettings;
  bool _useMockPrediction = true;
  bool _saveScanHistory = true;
  int _requestTimeoutSeconds = AppSettingsEntity.supportedTimeouts.first;
  int _analyticsWindowDays = AppSettingsEntity.supportedAnalyticsWindows.first;

  @override
  void initState() {
    super.initState();
    _endpointController = TextEditingController();
  }

  @override
  void dispose() {
    _endpointController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(appSettingsProvider);
    final mutationState = ref.watch(settingsMutationControllerProvider);
    final mutationController = ref.read(
      settingsMutationControllerProvider.notifier,
    );

    settingsAsync.whenData(_hydrateFormIfNeeded);

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: settingsAsync.when(
          data: (currentSettings) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Workspace Settings',
                subtitle:
                    'Persisted runtime configuration for prediction, history retention, and analytics behavior.',
              ),
              const SizedBox(height: AppSizes.xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth =
                      constraints.maxWidth >= AppSizes.tabletBreakpoint
                      ? (constraints.maxWidth - AppSizes.md) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: AppSizes.md,
                    runSpacing: AppSizes.md,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: CyberCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Prediction Runtime',
                                style: AppTextStyles.subheading,
                              ),
                              const SizedBox(height: AppSizes.xs),
                              Text(
                                _useMockPrediction
                                    ? 'Mock engine enabled for thesis-safe demos and offline validation.'
                                    : 'Live API mode enabled. Uploaded assets will be submitted to the configured prediction endpoint.',
                                style: AppTextStyles.bodySecondary,
                              ),
                              const SizedBox(height: AppSizes.md),
                              _KeyValueRow(
                                label: 'Endpoint',
                                value: _endpointController.text,
                              ),
                              const SizedBox(height: AppSizes.sm),
                              _KeyValueRow(
                                label: 'Timeout',
                                value: '$_requestTimeoutSeconds sec',
                              ),
                              const SizedBox(height: AppSizes.sm),
                              _KeyValueRow(
                                label: 'Max Upload',
                                value: '${currentSettings.maxUploadSizeMb} MB',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: CyberCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Data Policy',
                                style: AppTextStyles.subheading,
                              ),
                              const SizedBox(height: AppSizes.xs),
                              const Text(
                                'Local history and analytics preferences are persisted in Drift so the UI can survive restarts cleanly.',
                                style: AppTextStyles.bodySecondary,
                              ),
                              const SizedBox(height: AppSizes.md),
                              _KeyValueRow(
                                label: 'Save Scan History',
                                value: _saveScanHistory
                                    ? 'Enabled'
                                    : 'Disabled',
                              ),
                              const SizedBox(height: AppSizes.sm),
                              _KeyValueRow(
                                label: 'Analytics Window',
                                value: '$_analyticsWindowDays days',
                              ),
                              const SizedBox(height: AppSizes.sm),
                              const _KeyValueRow(
                                label: 'Storage',
                                value: 'SQLite (Drift)',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSizes.xl),
              CyberCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Prediction Service',
                      style: AppTextStyles.subheading,
                    ),
                    const SizedBox(height: AppSizes.md),
                    SwitchListTile(
                      value: _useMockPrediction,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Use Mock Prediction Engine'),
                      subtitle: const Text(
                        'Keep this enabled during defense demos without a running backend.',
                      ),
                      onChanged: (value) {
                        setState(() => _useMockPrediction = value);
                      },
                    ),
                    const SizedBox(height: AppSizes.sm),
                    AppTextField(
                      controller: _endpointController,
                      labelText: 'Prediction API Base URL',
                      hintText: 'http://127.0.0.1:8000',
                      prefixIcon: const Icon(Icons.link_outlined),
                    ),
                    const SizedBox(height: AppSizes.md),
                    _SettingsDropdown<int>(
                      label: 'Request Timeout',
                      value: _requestTimeoutSeconds,
                      items: AppSettingsEntity.supportedTimeouts,
                      itemLabel: (value) => '$value seconds',
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() => _requestTimeoutSeconds = value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.md),
              CyberCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'History and Analytics',
                      style: AppTextStyles.subheading,
                    ),
                    const SizedBox(height: AppSizes.md),
                    SwitchListTile(
                      value: _saveScanHistory,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Persist Completed Scans'),
                      subtitle: const Text(
                        'When disabled, completed scans remain visible in the current session but are not stored in local history.',
                      ),
                      onChanged: (value) {
                        setState(() => _saveScanHistory = value);
                      },
                    ),
                    const SizedBox(height: AppSizes.sm),
                    _SettingsDropdown<int>(
                      label: 'Analytics Window',
                      value: _analyticsWindowDays,
                      items: AppSettingsEntity.supportedAnalyticsWindows,
                      itemLabel: (value) => '$value days',
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() => _analyticsWindowDays = value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Save Settings',
                      icon: Icons.save_outlined,
                      isExpanded: true,
                      isLoading: mutationState.isLoading,
                      onPressed: mutationState.isLoading
                          ? null
                          : () => _saveSettings(context, mutationController),
                    ),
                  ),
                  const SizedBox(width: AppSizes.md),
                  Expanded(
                    child: SecondaryButton(
                      label: 'Reset Defaults',
                      icon: Icons.restart_alt_outlined,
                      isExpanded: true,
                      onPressed: mutationState.isLoading
                          ? null
                          : () => _resetSettings(context, mutationController),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),
              CyberCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Project Navigation',
                      style: AppTextStyles.subheading,
                    ),
                    const SizedBox(height: AppSizes.md),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            label: 'About Project',
                            icon: Icons.info_outline,
                            isExpanded: true,
                            onPressed: () => AppRouter.openAbout(context),
                          ),
                        ),
                        const SizedBox(width: AppSizes.md),
                        Expanded(
                          child: SecondaryButton(
                            label: 'Access Portal',
                            icon: Icons.admin_panel_settings_outlined,
                            isExpanded: true,
                            onPressed: () =>
                                AppRouter.openAuthentication(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.md),
              WarningCard(
                classification: _useMockPrediction
                    ? ScanClassification.suspicious
                    : ScanClassification.safe,
                title: _useMockPrediction
                    ? 'Mock engine active'
                    : 'Live endpoint active',
                message: _useMockPrediction
                    ? 'Prediction responses are simulated for demonstration stability. Switch to live mode when your CNN + Bi-LSTM API is available.'
                    : 'The scanner will post multipart data to the configured backend and update the UI from the returned prediction payload.',
              ),
            ],
          ),
          loading: () => const CyberCard(
            child: SizedBox(
              height: 180,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          error: (error, stackTrace) => ErrorCard(
            title: 'Settings unavailable',
            message: error.toString(),
          ),
        ),
      ),
    );
  }

  void _hydrateFormIfNeeded(AppSettingsEntity settings) {
    if (_loadedSettings != null) {
      return;
    }

    _loadedSettings = settings;
    _useMockPrediction = settings.useMockPrediction;
    _saveScanHistory = settings.saveScanHistory;
    _requestTimeoutSeconds = settings.requestTimeoutSeconds;
    _analyticsWindowDays = settings.analyticsWindowDays;
    _endpointController.text = settings.predictionBaseUrl;
  }

  Future<void> _saveSettings(
    BuildContext context,
    SettingsMutationController controller,
  ) async {
    final trimmedUrl = _endpointController.text.trim();

    if (trimmedUrl.isEmpty) {
      await CustomDialog.showAppDialog<void>(
        context: context,
        title: 'Invalid Endpoint',
        message: 'Prediction API Base URL cannot be empty.',
        icon: const Icon(Icons.error_outline, color: AppColors.danger),
      );
      return;
    }

    if (!_useMockPrediction) {
      final uri = Uri.tryParse(trimmedUrl);
      final isValid =
          uri != null &&
          uri.hasScheme &&
          (uri.scheme == 'http' || uri.scheme == 'https');

      if (!isValid) {
        await CustomDialog.showAppDialog<void>(
          context: context,
          title: 'Invalid Endpoint',
          message:
              'Live prediction mode requires a valid HTTP or HTTPS base URL.',
          icon: const Icon(Icons.error_outline, color: AppColors.danger),
        );
        return;
      }
    }

    final settings = AppSettingsEntity(
      useMockPrediction: _useMockPrediction,
      predictionBaseUrl: trimmedUrl,
      requestTimeoutSeconds: _requestTimeoutSeconds,
      saveScanHistory: _saveScanHistory,
      analyticsWindowDays: _analyticsWindowDays,
    );

    try {
      await controller.saveSettings(settings);
      _loadedSettings = settings;
      if (!context.mounted) {
        return;
      }

      CustomSnackbar.showSuccess(
        context,
        'Workspace settings saved successfully.',
      );
    } catch (error) {
      if (!context.mounted) {
        return;
      }

      await CustomDialog.showAppDialog<void>(
        context: context,
        title: 'Save Failed',
        message: error.toString(),
        icon: const Icon(Icons.error_outline, color: AppColors.danger),
      );
    }
  }

  Future<void> _resetSettings(
    BuildContext context,
    SettingsMutationController controller,
  ) async {
    try {
      await controller.resetSettings();
      final defaults = AppSettingsEntity.defaults();
      setState(() {
        _loadedSettings = defaults;
        _useMockPrediction = defaults.useMockPrediction;
        _saveScanHistory = defaults.saveScanHistory;
        _requestTimeoutSeconds = defaults.requestTimeoutSeconds;
        _analyticsWindowDays = defaults.analyticsWindowDays;
        _endpointController.text = defaults.predictionBaseUrl;
      });

      if (!context.mounted) {
        return;
      }

      CustomSnackbar.showInfo(context, 'Default settings restored.');
    } catch (error) {
      if (!context.mounted) {
        return;
      }

      await CustomDialog.showAppDialog<void>(
        context: context,
        title: 'Reset Failed',
        message: error.toString(),
        icon: const Icon(Icons.error_outline, color: AppColors.danger),
      );
    }
  }
}

class _SettingsDropdown<T> extends StatelessWidget {
  const _SettingsDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<T> items;
  final String Function(T value) itemLabel;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: items
          .map(
            (item) =>
                DropdownMenuItem<T>(value: item, child: Text(itemLabel(item))),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.bodySecondary)),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.body,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
