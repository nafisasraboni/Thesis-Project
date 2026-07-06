import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../history/domain/entities/scan_history_summary_entity.dart';
import '../providers/dashboard_summary_provider.dart';

/// Primary dashboard for security posture and scan activity.
class DashboardPage extends ConsumerWidget {
  /// Creates the dashboard page.
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final recentHistoryAsync = ref.watch(dashboardRecentHistoryProvider);

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
            summaryAsync.when(
              data: (summary) => _DashboardStatistics(summary: summary),
              loading: () => const _DashboardLoadingCard(),
              error: (error, stackTrace) => ErrorCard(
                title: 'Dashboard data unavailable',
                message: error.toString(),
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            summaryAsync.when(
              data: (summary) => _ThreatOverview(summary: summary),
              loading: () => const _DashboardLoadingCard(),
              error: (error, stackTrace) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSizes.xl),
            summaryAsync.when(
              data: (summary) => _LastScanSection(summary: summary),
              loading: () => const _DashboardLoadingCard(),
              error: (error, stackTrace) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSizes.xl),
            SectionHeader(
              title: 'Recent Scan History',
              subtitle:
                  'Persisted file and image assessments are stored in the local database automatically.',
              trailing: SecondaryButton(
                label: 'View All',
                icon: Icons.chevron_right_rounded,
                onPressed: () => AppRouter.goToHistory(context),
              ),
            ),
            const SizedBox(height: AppSizes.md),
            recentHistoryAsync.when(
              data: (records) => records.isEmpty
                  ? const CyberCard(
                      child: EmptyState(
                        icon: Icons.history_toggle_off_outlined,
                        title: 'No scan records available',
                        message:
                            'Run a file or image scan to populate the operational history panel.',
                      ),
                    )
                  : Column(
                      children: records
                          .map(
                            (record) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSizes.md,
                              ),
                              child: HistoryTile(
                                fileName: record.fileName,
                                extension: record.extension.toUpperCase(),
                                fileSize: AppFormatters.formatFileSize(
                                  record.sizeInBytes,
                                ),
                                scanDate: AppFormatters.formatDateTime(
                                  record.scanDate,
                                ),
                                classification: record.classification,
                                confidence: record.confidence,
                                onTap: () => AppRouter.openScanResult(
                                  context,
                                  record.toScanReport(),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
              loading: () => const _DashboardLoadingCard(),
              error: (error, stackTrace) => ErrorCard(
                title: 'Recent history unavailable',
                message: error.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardStatistics extends StatelessWidget {
  const _DashboardStatistics({required this.summary});

  final ScanHistorySummaryEntity summary;

  @override
  Widget build(BuildContext context) {
    final statistics = <_DashboardStat>[
      _DashboardStat(
        title: 'Total Scanned Files',
        value: '${summary.totalScannedFiles}',
        caption: 'Persisted local scan records',
        icon: Icons.insert_drive_file_outlined,
        color: AppColors.primary,
      ),
      _DashboardStat(
        title: 'Safe Files',
        value: '${summary.safeFiles}',
        caption: 'Low-risk assessments',
        icon: Icons.verified_user_outlined,
        color: AppColors.success,
      ),
      _DashboardStat(
        title: 'Suspicious Files',
        value: '${summary.suspiciousFiles}',
        caption: 'Manual review recommended',
        icon: Icons.warning_amber_rounded,
        color: AppColors.warning,
      ),
      _DashboardStat(
        title: 'Malware Detected',
        value: '${summary.malwareDetectedFiles}',
        caption: 'Critical findings',
        icon: Icons.report_gmailerrorred_rounded,
        color: AppColors.danger,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth >= AppSizes.tabletBreakpoint
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
    );
  }
}

class _ThreatOverview extends StatelessWidget {
  const _ThreatOverview({required this.summary});

  final ScanHistorySummaryEntity summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Threat Overview',
          subtitle:
              'Distribution panels summarize persisted model classifications.',
          trailing: SecondaryButton(
            label: 'Open Analytics',
            icon: Icons.analytics_outlined,
            onPressed: () => AppRouter.goToAnalytics(context),
          ),
        ),
        const SizedBox(height: AppSizes.md),
        CyberCard(
          child: Column(
            children: [
              _StatusBar(
                title: 'Safe Ratio',
                value: '${(summary.safeRatio * 100).toStringAsFixed(1)}%',
                progress: summary.safeRatio,
                color: AppColors.success,
              ),
              const SizedBox(height: AppSizes.md),
              _StatusBar(
                title: 'Suspicious Ratio',
                value: '${(summary.suspiciousRatio * 100).toStringAsFixed(1)}%',
                progress: summary.suspiciousRatio,
                color: AppColors.warning,
              ),
              const SizedBox(height: AppSizes.md),
              _StatusBar(
                title: 'Malware Ratio',
                value: '${(summary.malwareRatio * 100).toStringAsFixed(1)}%',
                progress: summary.malwareRatio,
                color: AppColors.danger,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LastScanSection extends StatelessWidget {
  const _LastScanSection({required this.summary});

  final ScanHistorySummaryEntity summary;

  @override
  Widget build(BuildContext context) {
    final lastScan = summary.lastScan;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Last Scan',
          subtitle:
              'The latest persisted detection summary is surfaced here for quick review.',
        ),
        const SizedBox(height: AppSizes.md),
        if (lastScan == null)
          const CyberCard(
            child: EmptyState(
              icon: Icons.search_off_rounded,
              title: 'No completed scans yet',
              message:
                  'The result summary will appear here after the first successful scan.',
            ),
          )
        else
          ResultCard(
            classification: lastScan.classification,
            confidence: lastScan.confidence,
            processingTime: lastScan.processingTime,
            message:
                '${lastScan.fileName} • ${AppFormatters.formatDateTime(lastScan.scanDate)}',
          ),
      ],
    );
  }
}

class _DashboardLoadingCard extends StatelessWidget {
  const _DashboardLoadingCard();

  @override
  Widget build(BuildContext context) {
    return const CyberCard(
      child: SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
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
