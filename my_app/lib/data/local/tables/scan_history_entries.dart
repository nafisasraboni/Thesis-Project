import 'package:drift/drift.dart';

/// Persistent scan history table.
class ScanHistoryEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get fileName => text()();

  TextColumn get extension => text()();

  IntColumn get sizeInBytes => integer()();

  TextColumn get sha256 => text()();

  TextColumn get prediction => text()();

  RealColumn get confidence => real()();

  TextColumn get processingTime => text()();

  TextColumn get probabilitiesJson => text()();

  TextColumn get assetType => text()();

  DateTimeColumn get scanDate => dateTime()();
}
