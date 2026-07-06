import 'dart:convert';

import 'package:drift/drift.dart';

import '../../features/history/data/models/scan_history_record_model.dart';
import '../../features/settings/data/models/app_settings_model.dart';
import '../../features/settings/domain/entities/app_settings_entity.dart';
import '../../features/history/domain/entities/history_query_entity.dart';
import 'connection/connection.dart';
import 'tables/app_settings_entries.dart';
import 'tables/scan_history_entries.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ScanHistoryEntries, AppSettingsEntries])
class AppDatabase extends _$AppDatabase {
  /// Creates the application database.
  AppDatabase({QueryExecutor? executor})
    : super(executor ?? openDatabaseConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (Migrator migrator, int from, int to) async {
      if (from < 2) {
        await migrator.createTable(appSettingsEntries);
      }
    },
  );

  Future<void> insertScanHistory(ScanHistoryEntriesCompanion entry) {
    return into(scanHistoryEntries).insert(entry);
  }

  Future<List<ScanHistoryRecordModel>> getHistory({
    required HistoryQueryEntity query,
  }) async {
    final statement = _buildHistoryQuery(query);
    final rows = await statement.get();
    return rows.map(ScanHistoryRecordModel.fromData).toList();
  }

  Stream<List<ScanHistoryRecordModel>> watchHistory({
    required HistoryQueryEntity query,
  }) {
    final statement = _buildHistoryQuery(query);
    return statement.watch().map(
      (rows) => rows.map(ScanHistoryRecordModel.fromData).toList(),
    );
  }

  Stream<List<ScanHistoryRecordModel>> watchRecentHistory({int limit = 5}) {
    final statement = select(scanHistoryEntries)
      ..orderBy([(table) => OrderingTerm.desc(table.scanDate)])
      ..limit(limit);

    return statement.watch().map(
      (rows) => rows.map(ScanHistoryRecordModel.fromData).toList(),
    );
  }

  Stream<List<ScanHistoryRecordModel>> watchAllHistory() {
    final statement = select(scanHistoryEntries)
      ..orderBy([(table) => OrderingTerm.desc(table.scanDate)]);

    return statement.watch().map(
      (rows) => rows.map(ScanHistoryRecordModel.fromData).toList(),
    );
  }

  Future<void> deleteHistoryEntry(int id) {
    return (delete(
      scanHistoryEntries,
    )..where((table) => table.id.equals(id))).go();
  }

  Future<void> clearHistory() {
    return delete(scanHistoryEntries).go();
  }

  Stream<AppSettingsModel> watchAppSettings() {
    final statement = select(appSettingsEntries);
    return statement.watchSingleOrNull().map((row) {
      if (row == null) {
        return AppSettingsModel.defaults();
      }

      return AppSettingsModel(
        useMockPrediction: row.useMockPrediction,
        predictionBaseUrl: row.predictionBaseUrl,
        requestTimeoutSeconds: row.requestTimeoutSeconds,
        saveScanHistory: row.saveScanHistory,
        analyticsWindowDays: row.analyticsWindowDays,
      );
    });
  }

  Future<AppSettingsModel> getAppSettings() async {
    final row = await select(appSettingsEntries).getSingleOrNull();
    if (row == null) {
      return AppSettingsModel.defaults();
    }

    return AppSettingsModel(
      useMockPrediction: row.useMockPrediction,
      predictionBaseUrl: row.predictionBaseUrl,
      requestTimeoutSeconds: row.requestTimeoutSeconds,
      saveScanHistory: row.saveScanHistory,
      analyticsWindowDays: row.analyticsWindowDays,
    );
  }

  Future<void> saveAppSettings(AppSettingsEntriesCompanion entry) {
    return into(appSettingsEntries).insertOnConflictUpdate(entry);
  }

  SimpleSelectStatement<$ScanHistoryEntriesTable, ScanHistoryEntry>
  _buildHistoryQuery(HistoryQueryEntity query) {
    final statement = select(scanHistoryEntries);

    final searchTerm = query.searchTerm.trim();
    if (searchTerm.isNotEmpty) {
      final pattern = '%${_escapeLike(searchTerm)}%';
      statement.where(
        (table) =>
            table.fileName.like(pattern, escapeChar: r'\') |
            table.sha256.like(pattern, escapeChar: r'\') |
            table.prediction.like(pattern, escapeChar: r'\') |
            table.extension.like(pattern, escapeChar: r'\'),
      );
    }

    if (query.filter != HistoryFilter.all) {
      statement.where(
        (table) => table.prediction.equals(query.filter.predictionLabel),
      );
    }

    statement.orderBy(_buildOrdering(query.sortOption));
    return statement;
  }

  List<OrderingTerm Function($ScanHistoryEntriesTable)> _buildOrdering(
    HistorySortOption sortOption,
  ) {
    switch (sortOption) {
      case HistorySortOption.oldestFirst:
        return [(table) => OrderingTerm.asc(table.scanDate)];
      case HistorySortOption.confidenceHighToLow:
        return [(table) => OrderingTerm.desc(table.confidence)];
      case HistorySortOption.confidenceLowToHigh:
        return [(table) => OrderingTerm.asc(table.confidence)];
      case HistorySortOption.nameAToZ:
        return [(table) => OrderingTerm.asc(table.fileName)];
      case HistorySortOption.nameZToA:
        return [(table) => OrderingTerm.desc(table.fileName)];
      case HistorySortOption.mostRecent:
        return [(table) => OrderingTerm.desc(table.scanDate)];
    }
  }

  String _escapeLike(String input) {
    return input
        .replaceAll(r'\', r'\\')
        .replaceAll('%', r'\%')
        .replaceAll('_', r'\_');
  }
}

AppSettingsEntriesCompanion buildAppSettingsCompanion(
  AppSettingsEntity settings,
) {
  return AppSettingsEntriesCompanion.insert(
    id: const Value<int>(1),
    useMockPrediction: settings.useMockPrediction,
    predictionBaseUrl: settings.predictionBaseUrl,
    requestTimeoutSeconds: settings.requestTimeoutSeconds,
    saveScanHistory: settings.saveScanHistory,
    analyticsWindowDays: settings.analyticsWindowDays,
  );
}

ScanHistoryEntriesCompanion buildScanHistoryCompanion({
  required String fileName,
  required String extension,
  required int sizeInBytes,
  required String sha256,
  required String prediction,
  required double confidence,
  required String processingTime,
  required Map<String, double> probabilities,
  required String assetType,
  required DateTime scanDate,
}) {
  return ScanHistoryEntriesCompanion.insert(
    fileName: fileName,
    extension: extension,
    sizeInBytes: sizeInBytes,
    sha256: sha256,
    prediction: prediction,
    confidence: confidence,
    processingTime: processingTime,
    probabilitiesJson: jsonEncode(probabilities),
    assetType: assetType,
    scanDate: scanDate,
  );
}
