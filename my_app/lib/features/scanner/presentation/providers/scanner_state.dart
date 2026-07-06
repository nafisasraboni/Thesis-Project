import '../../domain/entities/scan_asset_entity.dart';
import '../../domain/entities/scan_report_entity.dart';

/// High-level scanner workflow statuses.
enum ScannerStatus { idle, ready, scanning, success, failure }

/// Immutable state for the scanner presentation workflow.
class ScannerState {
  /// Creates scanner state.
  const ScannerState({
    this.status = ScannerStatus.idle,
    this.selectedAsset,
    this.currentStageIndex = -1,
    this.errorMessage,
    this.latestReport,
  });

  final ScannerStatus status;
  final ScanAssetEntity? selectedAsset;
  final int currentStageIndex;
  final String? errorMessage;
  final ScanReportEntity? latestReport;

  bool get isScanning => status == ScannerStatus.scanning;
  bool get hasSelection => selectedAsset != null;

  ScannerState copyWith({
    ScannerStatus? status,
    ScanAssetEntity? selectedAsset,
    bool clearSelectedAsset = false,
    int? currentStageIndex,
    String? errorMessage,
    bool clearError = false,
    ScanReportEntity? latestReport,
    bool clearLatestReport = false,
  }) {
    return ScannerState(
      status: status ?? this.status,
      selectedAsset: clearSelectedAsset
          ? null
          : (selectedAsset ?? this.selectedAsset),
      currentStageIndex: currentStageIndex ?? this.currentStageIndex,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      latestReport: clearLatestReport
          ? null
          : (latestReport ?? this.latestReport),
    );
  }
}
