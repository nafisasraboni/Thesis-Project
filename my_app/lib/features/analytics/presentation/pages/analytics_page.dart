import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../providers/analytics_providers.dart';
import '../widgets/analytics_distribution_chart.dart';
import '../widgets/analytics_top_file_types_chart.dart';
import '../widgets/analytics_trend_chart.dart';

/// Analytics page for operational metrics and charting surfaces.
class AnalyticsPage extends ConsumerWidget {
  /// Creates the analytics page.
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsOverviewProvider);

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: analyticsAsync.when(
          data: (analytics) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Detection Analytics',
                subtitle:
                    'Live metrics, scan-volume trends, and threat ratios derived from the local history store.',
                trailing: CyberCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.md,
                    vertical: AppSizes.sm,
                  ),
                  backgroundColor: AppColors.surfaceElevated,
                  child: Text(
                    'Window: ${analytics.windowDays} days',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth =
                      constraints.maxWidth >= AppSizes.desktopBreakpoint
                      ? (constraints.maxWidth - (AppSizes.md * 3)) / 4
                      : constraints.maxWidth >= AppSizes.tabletBreakpoint
                      ? (constraints.maxWidth - AppSizes.md) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: AppSizes.md,
                    runSpacing: AppSizes.md,
                    children: [
                      SizedBox(
                        width: itemWidth,
                        child: StatCard(
                          title: 'Daily Scans',
                          value: '${analytics.dailyScans}',
                          caption: 'Today',
                          icon: Icons.today_outlined,
                          highlightColor: AppColors.primary,
                        ),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: StatCard(
                          title: 'Weekly Scans',
                          value: '${analytics.weeklyScans}',
                          caption: 'Last 7 days',
                          icon: Icons.date_range_outlined,
                          highlightColor: AppColors.info,
                        ),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: StatCard(
                          title: 'Monthly Scans',
                          value: '${analytics.monthlyScans}',
                          caption: 'Last 30 days',
                          icon: Icons.calendar_month_outlined,
                          highlightColor: AppColors.warning,
                        ),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: StatCard(
                          title: 'Average Confidence',
                          value:
                              '${analytics.averageConfidence.toStringAsFixed(2)}%',
                          caption: '${analytics.totalScans} total records',
                          icon: Icons.track_changes_outlined,
                          highlightColor: AppColors.success,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSizes.xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final panelWidth =
                      constraints.maxWidth >= AppSizes.tabletBreakpoint
                      ? (constraints.maxWidth - AppSizes.md) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: AppSizes.md,
                    runSpacing: AppSizes.md,
                    children: [
                      SizedBox(
                        width: panelWidth,
                        child: AnalyticsTrendChart(
                          windowDays: analytics.windowDays,
                          buckets: analytics.trendBuckets,
                        ),
                      ),
                      SizedBox(
                        width: panelWidth,
                        child: AnalyticsDistributionChart(
                          safeRatio: analytics.safeRatio,
                          suspiciousRatio: analytics.suspiciousRatio,
                          malwareRatio: analytics.malwareRatio,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSizes.xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final panelWidth =
                      constraints.maxWidth >= AppSizes.tabletBreakpoint
                      ? (constraints.maxWidth - AppSizes.md) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: AppSizes.md,
                    runSpacing: AppSizes.md,
                    children: [
                      SizedBox(
                        width: panelWidth,
                        child: AnalyticsTopFileTypesChart(
                          fileTypes: analytics.topFileTypes,
                        ),
                      ),
                      SizedBox(
                        width: panelWidth,
                        child: CyberCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Detection Statistics',
                                style: AppTextStyles.subheading,
                              ),
                              const SizedBox(height: AppSizes.xs),
                              const Text(
                                'Ratios are calculated directly from persisted classification outcomes.',
                                style: AppTextStyles.bodySecondary,
                              ),
                              const SizedBox(height: AppSizes.lg),
                              _RatioRow(
                                label: 'Safe Ratio',
                                value: analytics.safeRatio,
                                color: AppColors.success,
                              ),
                              const SizedBox(height: AppSizes.md),
                              _RatioRow(
                                label: 'Suspicious Ratio',
                                value: analytics.suspiciousRatio,
                                color: AppColors.warning,
                              ),
                              const SizedBox(height: AppSizes.md),
                              _RatioRow(
                                label: 'Malware Ratio',
                                value: analytics.malwareRatio,
                                color: AppColors.danger,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
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
            title: 'Analytics unavailable',
            message: error.toString(),
          ),
        ),
      ),
    );
  }
}

class _RatioRow extends StatelessWidget {
  const _RatioRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(label)),
            Text('${(value * 100).toStringAsFixed(1)}%'),
          ],
        ),
        const SizedBox(height: AppSizes.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          child: LinearProgressIndicator(
            value: value.clamp(0, 1),
            minHeight: 10,
            color: color,
            backgroundColor: AppColors.surfaceSoft,
          ),
        ),
      ],
    );
  }
}
