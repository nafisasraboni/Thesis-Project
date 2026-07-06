import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/widgets/widgets.dart';

/// Analytics page for operational metrics and charting surfaces.
class AnalyticsPage extends StatelessWidget {
  /// Creates the analytics page.
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Detection Analytics',
              subtitle:
                  'Chart containers, ratios, and performance metrics are prepared for live database-backed scan insights.',
            ),
            const SizedBox(height: AppSizes.xl),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth =
                    constraints.maxWidth >= AppSizes.tabletBreakpoint
                    ? (constraints.maxWidth - (AppSizes.md * 2)) / 3
                    : constraints.maxWidth;

                return Wrap(
                  spacing: AppSizes.md,
                  runSpacing: AppSizes.md,
                  children: [
                    SizedBox(
                      width: itemWidth,
                      child: const StatCard(
                        title: 'Daily Scans',
                        value: '0',
                        caption: 'Today',
                        icon: Icons.today_outlined,
                        highlightColor: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: const StatCard(
                        title: 'Weekly Scans',
                        value: '0',
                        caption: 'Last 7 days',
                        icon: Icons.date_range_outlined,
                        highlightColor: AppColors.info,
                      ),
                    ),
                    SizedBox(
                      width: itemWidth,
                      child: const StatCard(
                        title: 'Monthly Scans',
                        value: '0',
                        caption: 'Last 30 days',
                        icon: Icons.calendar_month_outlined,
                        highlightColor: AppColors.warning,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSizes.xl),
            const CyberCard(
              child: EmptyState(
                icon: Icons.insights_outlined,
                title: 'Analytics visualizations pending data',
                message:
                    'Daily, weekly, monthly, ratio, confidence, and top file type charts will activate automatically once scan records exist.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
