import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/history_query_entity.dart';
import '../../domain/entities/scan_history_record_entity.dart';
import '../providers/history_actions_controller.dart';
import '../providers/history_query_controller.dart';

/// History page for persisted scan results and record management.
class HistoryPage extends ConsumerStatefulWidget {
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
            const SectionHeader(
              title: 'Scan History',
              subtitle: 'Search, sort, filter, delete, and export persisted records',
            ),
            const SizedBox(height: AppSizes.lg),
            _HeaderActions(
              query: query,
              actionsController: actionsController,
            ),
            const SizedBox(height: AppSizes.lg),
            AppTextField(
              controller: _searchController,
              labelText: 'Search history',
              hintText: 'Search by name, extension, or hash',
              prefixIcon: const Icon(Icons.search, size: AppSizes.iconMd),
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
              actionsController: actionsController,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions({required this.query, required this.actionsController});

  final HistoryQueryEntity query;
  final HistoryActionsController actionsController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 360) {
          return Column(
            children: [
              SecondaryButton(
                label: 'Export CSV',
                icon: Icons.download_outlined,
                isExpanded: true,
                onPressed: () => _exportHistory(context, actionsController, query),
              ),
              const SizedBox(height: AppSizes.sm),
              SecondaryButton(
                label: 'Clear History',
                icon: Icons.delete_sweep_outlined,
                isExpanded: true,
                onPressed: () => _confirmClearHistory(context, actionsController),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: 'Export CSV',
                icon: Icons.download_outlined,
                onPressed: () => _exportHistory(context, actionsController, query),
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: SecondaryButton(
                label: 'Clear History',
                icon: Icons.delete_sweep_outlined,
                onPressed: () => _confirmClearHistory(context, actionsController),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _exportHistory(
    BuildContext context,
    HistoryActionsController actionsController,
    HistoryQueryEntity query,
  ) async {
    final didExport = await actionsController.exportHistory(query);
    if (!context.mounted) return;
    if (didExport) {
      CustomSnackbar.showSuccess(context, 'CSV export completed');
    } else {
      CustomSnackbar.showInfo(context, 'No records were exported');
    }
  }

  Future<void> _confirmClearHistory(
    BuildContext context,
    HistoryActionsController actionsController,
  ) {
    return CustomDialog.showAppDialog<void>(
      context: context,
      title: 'Clear History',
      message: 'All persisted scan records will be permanently removed.',
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
              CustomSnackbar.showSuccess(context, 'History cleared');
            }
          },
          child: const Text('Clear'),
        ),
      ],
    );
  }
}

class _HistoryFilters extends StatelessWidget {
  const _HistoryFilters({required this.query, required this.queryController});

  final HistoryQueryEntity query;
  final HistoryQueryController queryController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 360;

        if (isWide) {
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSizes.sm),
                  child: _AppDropdown<HistoryFilter>(
                    label: 'Filter',
                    value: query.filter,
                    items: HistoryFilter.values,
                    itemLabel: (value) => value.label,
                    onChanged: (value) => queryController.setFilter(value!),
                  ),
                ),
              ),
              Expanded(
                child: _AppDropdown<HistorySortOption>(
                  label: 'Sort',
                  value: query.sortOption,
                  items: HistorySortOption.values,
                  itemLabel: (value) => value.label,
                  onChanged: (value) => queryController.setSortOption(value!),
                ),
              ),
            ],
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AppDropdown<HistoryFilter>(
              label: 'Filter',
              value: query.filter,
              items: HistoryFilter.values,
              itemLabel: (value) => value.label,
              onChanged: (value) => queryController.setFilter(value!),
            ),
            const SizedBox(height: AppSizes.sm),
            _AppDropdown<HistorySortOption>(
              label: 'Sort',
              value: query.sortOption,
              items: HistorySortOption.values,
              itemLabel: (value) => value.label,
              onChanged: (value) => queryController.setSortOption(value!),
            ),
          ],
        );
      },
    );
  }
}

class _AppDropdown<T> extends StatelessWidget {
  const _AppDropdown({
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
      isDense: true,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
      ),
      dropdownColor: AppColors.surface,
      iconEnabledColor: AppColors.textSecondary,
      isExpanded: true,
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabel(item),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _HistoryRecordList extends ConsumerWidget {
  const _HistoryRecordList({
    required this.recordsAsync,
    required this.actionsController,
  });

  final AsyncValue<List<ScanHistoryRecordEntity>> recordsAsync;
  final HistoryActionsController actionsController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return recordsAsync.when(
      data: (records) {
        if (records.isEmpty) {
          return const AppCard(
            child: EmptyState(
              icon: Icons.manage_search_outlined,
              title: 'No history available',
              message:
                  'Completed scans will be retained here for searching, filtering, and exporting',
            ),
          );
        }

        return Column(
          children: records
              .map(
                (record) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.md),
                  child: HistoryTile(
                    fileName: record.fileName,
                    extension: record.extension.toUpperCase(),
                    fileSize: AppFormatters.formatFileSize(record.sizeInBytes),
                    scanDate: AppFormatters.formatDateTime(record.scanDate),
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
        );
      },
      loading: () => const AppCard(
        child: SizedBox(
          height: 140,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, stackTrace) =>
          ErrorCard(title: 'History unavailable', message: error.toString()),
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
              CustomSnackbar.showSuccess(context, 'History record deleted');
            }
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}