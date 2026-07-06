import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';

import '../../domain/entities/scan_history_record_entity.dart';

/// Exports persisted history records into a CSV file.
class HistoryExportService {
  /// Creates the export service.
  const HistoryExportService();

  /// Writes the provided records to a CSV file chosen by the user.
  Future<bool> export(List<ScanHistoryRecordEntity> records) async {
    final fileLocation = await getSaveLocation(
      suggestedName: 'malware_scan_history.csv',
      acceptedTypeGroups: const <XTypeGroup>[
        XTypeGroup(label: 'CSV', extensions: <String>['csv']),
      ],
    );

    if (fileLocation == null) {
      return false;
    }

    final rows = <List<Object?>>[
      const <String>[
        'File Name',
        'Extension',
        'Size (Bytes)',
        'SHA256',
        'Prediction',
        'Confidence',
        'Processing Time',
        'Scan Date',
      ],
      ...records.map(
        (record) => <Object?>[
          record.fileName,
          record.extension,
          record.sizeInBytes,
          record.sha256,
          record.prediction,
          record.confidence.toStringAsFixed(2),
          record.processingTime,
          record.scanDate.toIso8601String(),
        ],
      ),
    ];

    final csv = const CsvEncoder().convert(rows);
    final file = XFile.fromData(
      Uint8List.fromList(utf8.encode(csv)),
      mimeType: 'text/csv',
      name: 'malware_scan_history.csv',
    );
    await file.saveTo(fileLocation.path);
    return true;
  }
}
