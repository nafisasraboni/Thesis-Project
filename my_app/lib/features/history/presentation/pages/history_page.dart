import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/history_query_entity.dart';
import '../../domain/entities/scan_history_record_entity.dart';
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
            _HistoryHeader(
              query: query,
              actionsController: actionsController,
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
            _HistoryFilters(
              query: query,
              queryController: queryController,
            ),
            const SizedBox(height: AppSizes.lg),
            _HistoryRecordList(
              recordsAsync: recordsAsync,
              queryController: queryController,
              actionsController: actionsController,
            ),
          ],
        ),
      ),
    );
  }
}

/// Header with title, subtitle, and action buttons.
class _HistoryHeader extends StatelessWidget {
  const _HistoryHeader({
    required this.query,
    required this.actionsController,
  });

  final HistoryQueryEntity query;
  final HistoryActionsController actionsController;

  @override
  Widget build(BuildContext context) {
    return SectionHeader(
      title: 'Scan History',
subtitle:
                        'Search, sort, filter, delete, clear, and '
                        'export persisted scan records.',
      trailing: _HeaderActions(
        query: query,
        actionsController: actionsController,
      ),
    );
  }
}

/// Export and clear action buttons.
class _HeaderActions extends StatelessWidget {
  const _HeaderActions({
    required this.query,
    required this.actionsController,
  });

  final HistoryQueryEntity query;
  final HistoryActionsController actionsController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SecondaryButton(
            label: 'Export CSV',
            icon: Icons.download_outlined,
            onPressed: () => _exportHistory(context, actionsController, query),
          ),
        ),
        const SizedBox(width: AppSizes.sm),
        Flexible(
          child: SecondaryButton(
            label: 'Clear History',
            icon: Icons.delete_sweep_outlined,
            onPressed: () => _confirmClearHistory(context, actionsController),
          ),
        ),
      ],
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

  Future<void> _confirmClearHistory(
    BuildContext context,
    HistoryActionsController actionsController,
  ) {
    return CustomDialog.showAppDialog<void>(
      context: context,
      title: 'Clear History',
message:
                        'All persisted scan records will be permanently '
                        'removed from the local database.',
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

/// Search field and filter/sort dropdowns.
class _HistoryFilters extends StatelessWidget {
  const _HistoryFilters({
    required this.query,
    required this.queryController,
  });

  final HistoryQueryEntity query;
  final HistoryQueryController queryController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: AppSizes.md,
          runSpacing: AppSizes.md,
          children: [
            Expanded(
              child: _HistoryDropdown<HistoryFilter>(
                label: 'Filter',
                value: query.filter,
                items: HistoryFilter.values,
                itemLabel: (value) => value.label,
                onChanged: (value) => queryController.setFilter(value!),
              ),
            ),
            Expanded(
              child: _HistoryDropdown<HistorySortOption>(
                label: 'Sort',
                value: query.sortOption,
                items: HistorySortOption.values,
                itemLabel: (value) => value.label,
                onChanged: (value) => queryController.setSortOption(value!),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Displays the list of history records or empty/loading/error states.
class _HistoryRecordList extends StatelessWidget {
  const _HistoryRecordList({
    required this.recordsAsync,
    required this.queryController,
    required this.actionsController,
  });

  final AsyncValue<List<ScanHistoryRecordEntity>> recordsAsync;
  final HistoryQueryController queryController;
  final HistoryActionsController actionsController;

  @override
  Widget build(BuildContext context) {
    return recordsAsync.when(
      data: (records) => records.isEmpty
          ? const CyberCard(
              child: EmptyState(
                icon: Icons.manage_search_outlined,
                title: 'No history available',
                message:
                    'Completed scans will be retained here for '
                    'searching, filtering, and exporting.',
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
    );
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
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabel(item),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}