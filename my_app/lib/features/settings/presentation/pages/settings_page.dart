import 'package:flutter/material.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/scan_classification.dart';
import '../../../../core/widgets/widgets.dart';

/// Settings page for workspace options and project access links.
class SettingsPage extends StatelessWidget {
  /// Creates the settings page.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Workspace Settings',
              subtitle:
                  'Configuration panels for connectivity, retention, and access controls are staged here.',
            ),
            const SizedBox(height: AppSizes.xl),
            const CyberCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Security Posture', style: AppTextStyles.subheading),
                  SizedBox(height: AppSizes.xs),
                  Text(
                    'The application shell is ready for secure storage, model endpoint configuration, and permission-aware scan controls.',
                    style: AppTextStyles.bodySecondary,
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
                          onPressed: () => AppRouter.openAbout(context),
                        ),
                      ),
                      const SizedBox(width: AppSizes.md),
                      Expanded(
                        child: SecondaryButton(
                          label: 'Access Portal',
                          icon: Icons.admin_panel_settings_outlined,
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
            const WarningCard(
              classification: ScanClassification.suspicious,
              title: 'Configuration note',
              message:
                  'Network retries, offline handling, and backend endpoint validation will be activated alongside the prediction data layer.',
            ),
          ],
        ),
      ),
    );
  }
}
