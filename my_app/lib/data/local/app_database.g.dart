// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ScanHistoryEntriesTable extends ScanHistoryEntries
    with TableInfo<$ScanHistoryEntriesTable, ScanHistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanHistoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extensionMeta = const VerificationMeta(
    'extension',
  );
  @override
  late final GeneratedColumn<String> extension = GeneratedColumn<String>(
    'extension',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeInBytesMeta = const VerificationMeta(
    'sizeInBytes',
  );
  @override
  late final GeneratedColumn<int> sizeInBytes = GeneratedColumn<int>(
    'size_in_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _predictionMeta = const VerificationMeta(
    'prediction',
  );
  @override
  late final GeneratedColumn<String> prediction = GeneratedColumn<String>(
    'prediction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _processingTimeMeta = const VerificationMeta(
    'processingTime',
  );
  @override
  late final GeneratedColumn<String> processingTime = GeneratedColumn<String>(
    'processing_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _probabilitiesJsonMeta = const VerificationMeta(
    'probabilitiesJson',
  );
  @override
  late final GeneratedColumn<String> probabilitiesJson =
      GeneratedColumn<String>(
        'probabilities_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _assetTypeMeta = const VerificationMeta(
    'assetType',
  );
  @override
  late final GeneratedColumn<String> assetType = GeneratedColumn<String>(
    'asset_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scanDateMeta = const VerificationMeta(
    'scanDate',
  );
  @override
  late final GeneratedColumn<DateTime> scanDate = GeneratedColumn<DateTime>(
    'scan_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fileName,
    extension,
    sizeInBytes,
    sha256,
    prediction,
    confidence,
    processingTime,
    probabilitiesJson,
    assetType,
    scanDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_history_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanHistoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('extension')) {
      context.handle(
        _extensionMeta,
        extension.isAcceptableOrUnknown(data['extension']!, _extensionMeta),
      );
    } else if (isInserting) {
      context.missing(_extensionMeta);
    }
    if (data.containsKey('size_in_bytes')) {
      context.handle(
        _sizeInBytesMeta,
        sizeInBytes.isAcceptableOrUnknown(
          data['size_in_bytes']!,
          _sizeInBytesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sizeInBytesMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('prediction')) {
      context.handle(
        _predictionMeta,
        prediction.isAcceptableOrUnknown(data['prediction']!, _predictionMeta),
      );
    } else if (isInserting) {
      context.missing(_predictionMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('processing_time')) {
      context.handle(
        _processingTimeMeta,
        processingTime.isAcceptableOrUnknown(
          data['processing_time']!,
          _processingTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_processingTimeMeta);
    }
    if (data.containsKey('probabilities_json')) {
      context.handle(
        _probabilitiesJsonMeta,
        probabilitiesJson.isAcceptableOrUnknown(
          data['probabilities_json']!,
          _probabilitiesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_probabilitiesJsonMeta);
    }
    if (data.containsKey('asset_type')) {
      context.handle(
        _assetTypeMeta,
        assetType.isAcceptableOrUnknown(data['asset_type']!, _assetTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_assetTypeMeta);
    }
    if (data.containsKey('scan_date')) {
      context.handle(
        _scanDateMeta,
        scanDate.isAcceptableOrUnknown(data['scan_date']!, _scanDateMeta),
      );
    } else if (isInserting) {
      context.missing(_scanDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanHistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanHistoryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      extension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extension'],
      )!,
      sizeInBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_in_bytes'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      prediction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prediction'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      processingTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_time'],
      )!,
      probabilitiesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}probabilities_json'],
      )!,
      assetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_type'],
      )!,
      scanDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scan_date'],
      )!,
    );
  }

  @override
  $ScanHistoryEntriesTable createAlias(String alias) {
    return $ScanHistoryEntriesTable(attachedDatabase, alias);
  }
}

class ScanHistoryEntry extends DataClass
    implements Insertable<ScanHistoryEntry> {
  final int id;
  final String fileName;
  final String extension;
  final int sizeInBytes;
  final String sha256;
  final String prediction;
  final double confidence;
  final String processingTime;
  final String probabilitiesJson;
  final String assetType;
  final DateTime scanDate;
  const ScanHistoryEntry({
    required this.id,
    required this.fileName,
    required this.extension,
    required this.sizeInBytes,
    required this.sha256,
    required this.prediction,
    required this.confidence,
    required this.processingTime,
    required this.probabilitiesJson,
    required this.assetType,
    required this.scanDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_name'] = Variable<String>(fileName);
    map['extension'] = Variable<String>(extension);
    map['size_in_bytes'] = Variable<int>(sizeInBytes);
    map['sha256'] = Variable<String>(sha256);
    map['prediction'] = Variable<String>(prediction);
    map['confidence'] = Variable<double>(confidence);
    map['processing_time'] = Variable<String>(processingTime);
    map['probabilities_json'] = Variable<String>(probabilitiesJson);
    map['asset_type'] = Variable<String>(assetType);
    map['scan_date'] = Variable<DateTime>(scanDate);
    return map;
  }

  ScanHistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return ScanHistoryEntriesCompanion(
      id: Value(id),
      fileName: Value(fileName),
      extension: Value(extension),
      sizeInBytes: Value(sizeInBytes),
      sha256: Value(sha256),
      prediction: Value(prediction),
      confidence: Value(confidence),
      processingTime: Value(processingTime),
      probabilitiesJson: Value(probabilitiesJson),
      assetType: Value(assetType),
      scanDate: Value(scanDate),
    );
  }

  factory ScanHistoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanHistoryEntry(
      id: serializer.fromJson<int>(json['id']),
      fileName: serializer.fromJson<String>(json['fileName']),
      extension: serializer.fromJson<String>(json['extension']),
      sizeInBytes: serializer.fromJson<int>(json['sizeInBytes']),
      sha256: serializer.fromJson<String>(json['sha256']),
      prediction: serializer.fromJson<String>(json['prediction']),
      confidence: serializer.fromJson<double>(json['confidence']),
      processingTime: serializer.fromJson<String>(json['processingTime']),
      probabilitiesJson: serializer.fromJson<String>(json['probabilitiesJson']),
      assetType: serializer.fromJson<String>(json['assetType']),
      scanDate: serializer.fromJson<DateTime>(json['scanDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileName': serializer.toJson<String>(fileName),
      'extension': serializer.toJson<String>(extension),
      'sizeInBytes': serializer.toJson<int>(sizeInBytes),
      'sha256': serializer.toJson<String>(sha256),
      'prediction': serializer.toJson<String>(prediction),
      'confidence': serializer.toJson<double>(confidence),
      'processingTime': serializer.toJson<String>(processingTime),
      'probabilitiesJson': serializer.toJson<String>(probabilitiesJson),
      'assetType': serializer.toJson<String>(assetType),
      'scanDate': serializer.toJson<DateTime>(scanDate),
    };
  }

  ScanHistoryEntry copyWith({
    int? id,
    String? fileName,
    String? extension,
    int? sizeInBytes,
    String? sha256,
    String? prediction,
    double? confidence,
    String? processingTime,
    String? probabilitiesJson,
    String? assetType,
    DateTime? scanDate,
  }) => ScanHistoryEntry(
    id: id ?? this.id,
    fileName: fileName ?? this.fileName,
    extension: extension ?? this.extension,
    sizeInBytes: sizeInBytes ?? this.sizeInBytes,
    sha256: sha256 ?? this.sha256,
    prediction: prediction ?? this.prediction,
    confidence: confidence ?? this.confidence,
    processingTime: processingTime ?? this.processingTime,
    probabilitiesJson: probabilitiesJson ?? this.probabilitiesJson,
    assetType: assetType ?? this.assetType,
    scanDate: scanDate ?? this.scanDate,
  );
  ScanHistoryEntry copyWithCompanion(ScanHistoryEntriesCompanion data) {
    return ScanHistoryEntry(
      id: data.id.present ? data.id.value : this.id,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      extension: data.extension.present ? data.extension.value : this.extension,
      sizeInBytes: data.sizeInBytes.present
          ? data.sizeInBytes.value
          : this.sizeInBytes,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      prediction: data.prediction.present
          ? data.prediction.value
          : this.prediction,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      processingTime: data.processingTime.present
          ? data.processingTime.value
          : this.processingTime,
      probabilitiesJson: data.probabilitiesJson.present
          ? data.probabilitiesJson.value
          : this.probabilitiesJson,
      assetType: data.assetType.present ? data.assetType.value : this.assetType,
      scanDate: data.scanDate.present ? data.scanDate.value : this.scanDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanHistoryEntry(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('extension: $extension, ')
          ..write('sizeInBytes: $sizeInBytes, ')
          ..write('sha256: $sha256, ')
          ..write('prediction: $prediction, ')
          ..write('confidence: $confidence, ')
          ..write('processingTime: $processingTime, ')
          ..write('probabilitiesJson: $probabilitiesJson, ')
          ..write('assetType: $assetType, ')
          ..write('scanDate: $scanDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fileName,
    extension,
    sizeInBytes,
    sha256,
    prediction,
    confidence,
    processingTime,
    probabilitiesJson,
    assetType,
    scanDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanHistoryEntry &&
          other.id == this.id &&
          other.fileName == this.fileName &&
          other.extension == this.extension &&
          other.sizeInBytes == this.sizeInBytes &&
          other.sha256 == this.sha256 &&
          other.prediction == this.prediction &&
          other.confidence == this.confidence &&
          other.processingTime == this.processingTime &&
          other.probabilitiesJson == this.probabilitiesJson &&
          other.assetType == this.assetType &&
          other.scanDate == this.scanDate);
}

class ScanHistoryEntriesCompanion extends UpdateCompanion<ScanHistoryEntry> {
  final Value<int> id;
  final Value<String> fileName;
  final Value<String> extension;
  final Value<int> sizeInBytes;
  final Value<String> sha256;
  final Value<String> prediction;
  final Value<double> confidence;
  final Value<String> processingTime;
  final Value<String> probabilitiesJson;
  final Value<String> assetType;
  final Value<DateTime> scanDate;
  const ScanHistoryEntriesCompanion({
    this.id = const Value.absent(),
    this.fileName = const Value.absent(),
    this.extension = const Value.absent(),
    this.sizeInBytes = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.prediction = const Value.absent(),
    this.confidence = const Value.absent(),
    this.processingTime = const Value.absent(),
    this.probabilitiesJson = const Value.absent(),
    this.assetType = const Value.absent(),
    this.scanDate = const Value.absent(),
  });
  ScanHistoryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String fileName,
    required String extension,
    required int sizeInBytes,
    required String sha256,
    required String prediction,
    required double confidence,
    required String processingTime,
    required String probabilitiesJson,
    required String assetType,
    required DateTime scanDate,
  }) : fileName = Value(fileName),
       extension = Value(extension),
       sizeInBytes = Value(sizeInBytes),
       sha256 = Value(sha256),
       prediction = Value(prediction),
       confidence = Value(confidence),
       processingTime = Value(processingTime),
       probabilitiesJson = Value(probabilitiesJson),
       assetType = Value(assetType),
       scanDate = Value(scanDate);
  static Insertable<ScanHistoryEntry> custom({
    Expression<int>? id,
    Expression<String>? fileName,
    Expression<String>? extension,
    Expression<int>? sizeInBytes,
    Expression<String>? sha256,
    Expression<String>? prediction,
    Expression<double>? confidence,
    Expression<String>? processingTime,
    Expression<String>? probabilitiesJson,
    Expression<String>? assetType,
    Expression<DateTime>? scanDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileName != null) 'file_name': fileName,
      if (extension != null) 'extension': extension,
      if (sizeInBytes != null) 'size_in_bytes': sizeInBytes,
      if (sha256 != null) 'sha256': sha256,
      if (prediction != null) 'prediction': prediction,
      if (confidence != null) 'confidence': confidence,
      if (processingTime != null) 'processing_time': processingTime,
      if (probabilitiesJson != null) 'probabilities_json': probabilitiesJson,
      if (assetType != null) 'asset_type': assetType,
      if (scanDate != null) 'scan_date': scanDate,
    });
  }

  ScanHistoryEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? fileName,
    Value<String>? extension,
    Value<int>? sizeInBytes,
    Value<String>? sha256,
    Value<String>? prediction,
    Value<double>? confidence,
    Value<String>? processingTime,
    Value<String>? probabilitiesJson,
    Value<String>? assetType,
    Value<DateTime>? scanDate,
  }) {
    return ScanHistoryEntriesCompanion(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      extension: extension ?? this.extension,
      sizeInBytes: sizeInBytes ?? this.sizeInBytes,
      sha256: sha256 ?? this.sha256,
      prediction: prediction ?? this.prediction,
      confidence: confidence ?? this.confidence,
      processingTime: processingTime ?? this.processingTime,
      probabilitiesJson: probabilitiesJson ?? this.probabilitiesJson,
      assetType: assetType ?? this.assetType,
      scanDate: scanDate ?? this.scanDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (extension.present) {
      map['extension'] = Variable<String>(extension.value);
    }
    if (sizeInBytes.present) {
      map['size_in_bytes'] = Variable<int>(sizeInBytes.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (prediction.present) {
      map['prediction'] = Variable<String>(prediction.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (processingTime.present) {
      map['processing_time'] = Variable<String>(processingTime.value);
    }
    if (probabilitiesJson.present) {
      map['probabilities_json'] = Variable<String>(probabilitiesJson.value);
    }
    if (assetType.present) {
      map['asset_type'] = Variable<String>(assetType.value);
    }
    if (scanDate.present) {
      map['scan_date'] = Variable<DateTime>(scanDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanHistoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('extension: $extension, ')
          ..write('sizeInBytes: $sizeInBytes, ')
          ..write('sha256: $sha256, ')
          ..write('prediction: $prediction, ')
          ..write('confidence: $confidence, ')
          ..write('processingTime: $processingTime, ')
          ..write('probabilitiesJson: $probabilitiesJson, ')
          ..write('assetType: $assetType, ')
          ..write('scanDate: $scanDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScanHistoryEntriesTable scanHistoryEntries =
      $ScanHistoryEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scanHistoryEntries];
}

typedef $$ScanHistoryEntriesTableCreateCompanionBuilder =
    ScanHistoryEntriesCompanion Function({
      Value<int> id,
      required String fileName,
      required String extension,
      required int sizeInBytes,
      required String sha256,
      required String prediction,
      required double confidence,
      required String processingTime,
      required String probabilitiesJson,
      required String assetType,
      required DateTime scanDate,
    });
typedef $$ScanHistoryEntriesTableUpdateCompanionBuilder =
    ScanHistoryEntriesCompanion Function({
      Value<int> id,
      Value<String> fileName,
      Value<String> extension,
      Value<int> sizeInBytes,
      Value<String> sha256,
      Value<String> prediction,
      Value<double> confidence,
      Value<String> processingTime,
      Value<String> probabilitiesJson,
      Value<String> assetType,
      Value<DateTime> scanDate,
    });

class $$ScanHistoryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ScanHistoryEntriesTable> {
  $$ScanHistoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeInBytes => $composableBuilder(
    column: $table.sizeInBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prediction => $composableBuilder(
    column: $table.prediction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingTime => $composableBuilder(
    column: $table.processingTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get probabilitiesJson => $composableBuilder(
    column: $table.probabilitiesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetType => $composableBuilder(
    column: $table.assetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scanDate => $composableBuilder(
    column: $table.scanDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScanHistoryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanHistoryEntriesTable> {
  $$ScanHistoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeInBytes => $composableBuilder(
    column: $table.sizeInBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prediction => $composableBuilder(
    column: $table.prediction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingTime => $composableBuilder(
    column: $table.processingTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get probabilitiesJson => $composableBuilder(
    column: $table.probabilitiesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetType => $composableBuilder(
    column: $table.assetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scanDate => $composableBuilder(
    column: $table.scanDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScanHistoryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanHistoryEntriesTable> {
  $$ScanHistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get extension =>
      $composableBuilder(column: $table.extension, builder: (column) => column);

  GeneratedColumn<int> get sizeInBytes => $composableBuilder(
    column: $table.sizeInBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<String> get prediction => $composableBuilder(
    column: $table.prediction,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingTime => $composableBuilder(
    column: $table.processingTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get probabilitiesJson => $composableBuilder(
    column: $table.probabilitiesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assetType =>
      $composableBuilder(column: $table.assetType, builder: (column) => column);

  GeneratedColumn<DateTime> get scanDate =>
      $composableBuilder(column: $table.scanDate, builder: (column) => column);
}

class $$ScanHistoryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanHistoryEntriesTable,
          ScanHistoryEntry,
          $$ScanHistoryEntriesTableFilterComposer,
          $$ScanHistoryEntriesTableOrderingComposer,
          $$ScanHistoryEntriesTableAnnotationComposer,
          $$ScanHistoryEntriesTableCreateCompanionBuilder,
          $$ScanHistoryEntriesTableUpdateCompanionBuilder,
          (
            ScanHistoryEntry,
            BaseReferences<
              _$AppDatabase,
              $ScanHistoryEntriesTable,
              ScanHistoryEntry
            >,
          ),
          ScanHistoryEntry,
          PrefetchHooks Function()
        > {
  $$ScanHistoryEntriesTableTableManager(
    _$AppDatabase db,
    $ScanHistoryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanHistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanHistoryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanHistoryEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> extension = const Value.absent(),
                Value<int> sizeInBytes = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<String> prediction = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String> processingTime = const Value.absent(),
                Value<String> probabilitiesJson = const Value.absent(),
                Value<String> assetType = const Value.absent(),
                Value<DateTime> scanDate = const Value.absent(),
              }) => ScanHistoryEntriesCompanion(
                id: id,
                fileName: fileName,
                extension: extension,
                sizeInBytes: sizeInBytes,
                sha256: sha256,
                prediction: prediction,
                confidence: confidence,
                processingTime: processingTime,
                probabilitiesJson: probabilitiesJson,
                assetType: assetType,
                scanDate: scanDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fileName,
                required String extension,
                required int sizeInBytes,
                required String sha256,
                required String prediction,
                required double confidence,
                required String processingTime,
                required String probabilitiesJson,
                required String assetType,
                required DateTime scanDate,
              }) => ScanHistoryEntriesCompanion.insert(
                id: id,
                fileName: fileName,
                extension: extension,
                sizeInBytes: sizeInBytes,
                sha256: sha256,
                prediction: prediction,
                confidence: confidence,
                processingTime: processingTime,
                probabilitiesJson: probabilitiesJson,
                assetType: assetType,
                scanDate: scanDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScanHistoryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanHistoryEntriesTable,
      ScanHistoryEntry,
      $$ScanHistoryEntriesTableFilterComposer,
      $$ScanHistoryEntriesTableOrderingComposer,
      $$ScanHistoryEntriesTableAnnotationComposer,
      $$ScanHistoryEntriesTableCreateCompanionBuilder,
      $$ScanHistoryEntriesTableUpdateCompanionBuilder,
      (
        ScanHistoryEntry,
        BaseReferences<
          _$AppDatabase,
          $ScanHistoryEntriesTable,
          ScanHistoryEntry
        >,
      ),
      ScanHistoryEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScanHistoryEntriesTableTableManager get scanHistoryEntries =>
      $$ScanHistoryEntriesTableTableManager(_db, _db.scanHistoryEntries);
}
