import 'package:flutter/material.dart';

import '../../../../core/theme/app_sizes.dart';
import '../../../../core/widgets/widgets.dart';

/// History page for persisted scan results and record management.
class HistoryPage extends StatelessWidget {
  /// Creates the history page.
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Scan History',
              subtitle:
                  'Local persistence, filtering, sorting, deletion, and CSV export will be connected in the database phase.',
              trailing: SecondaryButton(
                label: 'Export CSV',
                icon: Icons.download_outlined,
                onPressed: () => CustomDialog.showAppDialog<void>(
                  context: context,
                  title: 'History Export Prepared',
                  message:
                      'CSV export is planned for the persistence phase once historical records are stored locally.',
                ),
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            const AppTextField(
              labelText: 'Search history',
              hintText: 'Search by file name, hash, or result',
              prefixIcon: Icon(Icons.search),
            ),
            const SizedBox(height: AppSizes.md),
            const CyberCard(
              child: EmptyState(
                icon: Icons.manage_search_outlined,
                title: 'No history available',
                message:
                    'Completed scans will be retained here with filtering, sorting, and export controls.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
