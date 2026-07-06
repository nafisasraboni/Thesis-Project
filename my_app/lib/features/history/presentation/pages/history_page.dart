import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/history_query_entity.dart';
import '../providers/history_actions_controller.dart';
import '../providers/history_query_controller.dart';

/// History page for persisted scan results and record management.
class HistoryPage extends ConsumerStatefulWidget {
  /// Creates the history page.
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(historyQueryControllerProvider);
    final recordsAsync = ref.watch(historyRecordsProvider);
    final queryController = ref.read(historyQueryControllerProvider.notifier);
    final actionsController = ref.read(historyActionsControllerProvider);

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Scan History',
              subtitle:
                  'Search, sort, filter, delete, clear, and export persisted scan records from the local database.',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SecondaryButton(
                    label: 'Export CSV',
                    icon: Icons.download_outlined,
                    onPressed: () =>
                        _exportHistory(context, actionsController, query),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  SecondaryButton(
                    label: 'Clear History',
                    icon: Icons.delete_sweep_outlined,
                    onPressed: () =>
                        _confirmClearHistory(context, actionsController),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            AppTextField(
              controller: _searchController,
              labelText: 'Search history',
              hintText: 'Search by file name, extension, hash, or result',
              prefixIcon: const Icon(Icons.search),
              onChanged: queryController.setSearchTerm,
            ),
            const SizedBox(height: AppSizes.md),
            Wrap(
              spacing: AppSizes.md,
              runSpacing: AppSizes.md,
              children: [
                _HistoryDropdown<HistoryFilter>(
                  label: 'Filter',
                  value: query.filter,
                  items: HistoryFilter.values,
                  itemLabel: (value) => value.label,
                  onChanged: (value) => queryController.setFilter(value!),
                ),
                _HistoryDropdown<HistorySortOption>(
                  label: 'Sort',
                  value: query.sortOption,
                  items: HistorySortOption.values,
                  itemLabel: (value) => value.label,
                  onChanged: (value) => queryController.setSortOption(value!),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.lg),
            recordsAsync.when(
              data: (records) => records.isEmpty
                  ? const CyberCard(
                      child: EmptyState(
                        icon: Icons.manage_search_outlined,
                        title: 'No history available',
                        message:
                            'Completed scans will be retained here with searchable, filterable, and exportable records.',
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
                                onDelete: () => _confirmDeleteEntry(
                                  context,
                                  actionsController,
                                  record.id,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
              loading: () => const CyberCard(
                child: SizedBox(
                  height: 140,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              error: (error, stackTrace) => ErrorCard(
                title: 'History unavailable',
                message: error.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportHistory(
    BuildContext context,
    HistoryActionsController actionsController,
    HistoryQueryEntity query,
  ) async {
    final didExport = await actionsController.exportHistory(query);
    if (!context.mounted) {
      return;
    }

    if (didExport) {
      CustomSnackbar.showSuccess(context, 'CSV export completed.');
    } else {
      CustomSnackbar.showInfo(context, 'No records were exported.');
    }
  }

  Future<void> _confirmDeleteEntry(
    BuildContext context,
    HistoryActionsController actionsController,
    int id,
  ) {
    return CustomDialog.showAppDialog<void>(
      context: context,
      title: 'Delete Record',
      message: 'This scan record will be removed from local history.',
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await actionsController.deleteHistoryEntry(id);
            if (context.mounted) {
              CustomSnackbar.showSuccess(context, 'History record deleted.');
            }
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  Future<void> _confirmClearHistory(
    BuildContext context,
    HistoryActionsController actionsController,
  ) {
    return CustomDialog.showAppDialog<void>(
      context: context,
      title: 'Clear History',
      message:
          'All persisted scan records will be permanently removed from the local database.',
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await actionsController.clearHistory();
            if (context.mounted) {
              CustomSnackbar.showSuccess(context, 'History cleared.');
            }
          },
          child: const Text('Clear'),
        ),
      ],
    );
  }
}

class _HistoryDropdown<T> extends StatelessWidget {
  const _HistoryDropdown({
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
    return SizedBox(
      width: 220,
      child: DropdownButtonFormField<T>(
        initialValue: value,
        decoration: InputDecoration(labelText: label),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(itemLabel(item)),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
