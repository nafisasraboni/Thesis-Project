import 'package:drift/drift.dart';

/// Persistent workspace settings table.
class AppSettingsEntries extends Table {
  IntColumn get id => integer()();

  BoolColumn get useMockPrediction => boolean()();

  TextColumn get predictionBaseUrl => text()();

  IntColumn get requestTimeoutSeconds => integer()();

  BoolColumn get saveScanHistory => boolean()();

  IntColumn get analyticsWindowDays => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
