import 'package:flutter/material.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/utils/scan_classification.dart';
import '../../../../core/widgets/widgets.dart';

/// Primary dashboard for security posture and scan activity.
class DashboardPage extends StatelessWidget {
  /// Creates the dashboard page.
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const statistics = <_DashboardStat>[
      _DashboardStat(
        title: 'Total Scanned Files',
        value: '0',
        caption: 'No scans recorded yet',
        icon: Icons.insert_drive_file_outlined,
        color: AppColors.primary,
      ),
      _DashboardStat(
        title: 'Safe Files',
        value: '0',
        caption: 'Awaiting baseline results',
        icon: Icons.verified_user_outlined,
        color: AppColors.success,
      ),
      _DashboardStat(
        title: 'Suspicious Files',
        value: '0',
        caption: 'No elevated items detected',
        icon: Icons.warning_amber_rounded,
        color: AppColors.warning,
      ),
      _DashboardStat(
        title: 'Malware Detected',
        value: '0',
        caption: 'Critical findings will appear here',
        icon: Icons.report_gmailerrorred_rounded,
        color: AppColors.danger,
      ),
    ];

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Security Overview',
              subtitle:
                  'Operational snapshot of the malware detection environment.',
              trailing: PrimaryButton(
                label: 'Quick Scan',
                icon: Icons.radar_outlined,
                onPressed: () => AppRouter.goToScanner(context),
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth =
                    constraints.maxWidth >= AppSizes.tabletBreakpoint
                    ? (constraints.maxWidth - AppSizes.md) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: AppSizes.md,
                  runSpacing: AppSizes.md,
                  children: statistics
                      .map(
                        (stat) => SizedBox(
                          width: itemWidth,
                          child: StatCard(
                            title: stat.title,
                            value: stat.value,
                            caption: stat.caption,
                            icon: stat.icon,
                            highlightColor: stat.color,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: AppSizes.xl),
            const SectionHeader(
              title: 'Threat Overview',
              subtitle:
                  'Distribution panels will visualize prediction results as scans are recorded.',
            ),
            const SizedBox(height: AppSizes.md),
            const CyberCard(
              child: Column(
                children: [
                  _StatusBar(
                    title: 'Safe Ratio',
                    value: '0%',
                    progress: 0,
                    color: AppColors.success,
                  ),
                  SizedBox(height: AppSizes.md),
                  _StatusBar(
                    title: 'Suspicious Ratio',
                    value: '0%',
                    progress: 0,
                    color: AppColors.warning,
                  ),
                  SizedBox(height: AppSizes.md),
                  _StatusBar(
                    title: 'Malware Ratio',
                    value: '0%',
                    progress: 0,
                    color: AppColors.danger,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            const SectionHeader(
              title: 'Last Scan',
              subtitle:
                  'The latest detection summary will surface here for quick review.',
            ),
            const SizedBox(height: AppSizes.md),
            const ResultCard(
              classification: ScanClassification.safe,
              confidence: 0,
              message:
                  'No inference has been executed yet. The prediction card is ready for the API response contract.',
              processingTime: '--',
            ),
            const SizedBox(height: AppSizes.xl),
            const SectionHeader(
              title: 'Recent Scan History',
              subtitle:
                  'Recent file and image assessments will be saved to local storage in the next phase.',
            ),
            const SizedBox(height: AppSizes.md),
            const CyberCard(
              child: EmptyState(
                icon: Icons.history_toggle_off_outlined,
                title: 'No scan records available',
                message:
                    'Run a file or image scan to populate the operational history panel.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardStat {
  const _DashboardStat({
    required this.title,
    required this.value,
    required this.caption,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String caption;
  final IconData icon;
  final Color color;
}

class _StatusBar extends StatelessWidget {
  const _StatusBar({
    required this.title,
    required this.value,
    required this.progress,
    required this.color,
  });

  final String title;
  final String value;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(title)),
            Text(value),
          ],
        ),
        const SizedBox(height: AppSizes.xs),
        LinearProgressIndicator(value: progress, color: color, minHeight: 8),
      ],
    );
  }
}
