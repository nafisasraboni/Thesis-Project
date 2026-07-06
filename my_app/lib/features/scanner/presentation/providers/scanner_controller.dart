import 'package:crypto/crypto.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_limits.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../features/history/domain/usecases/save_scan_history_use_case.dart';
import '../../../../shared/providers/history_providers.dart';
import '../../data/datasources/prediction_remote_data_source.dart';
import '../../data/repositories/prediction_repository_impl.dart';
import '../../data/services/prediction_service.dart';
import '../../domain/entities/scan_asset_entity.dart';
import '../../domain/entities/scan_report_entity.dart';
import '../../domain/usecases/prediction_use_case.dart';
import 'scanner_state.dart';

const scannerStages = <String>[
  'Uploading...',
  'Checking Integrity...',
  'Extracting Features...',
  'Running CNN...',
  'Running Bi-LSTM...',
  'Calculating Confidence...',
  'Generating Result...',
  'Completed.',
];

final predictionServiceProvider = Provider<PredictionService>(
  (ref) => PredictionService(ref.watch(dioProvider)),
);

final predictionRemoteDataSourceProvider = Provider<PredictionRemoteDataSource>(
  (ref) => PredictionRemoteDataSource(ref.watch(predictionServiceProvider)),
);

final predictionRepositoryProvider = Provider<PredictionRepositoryImpl>(
  (ref) =>
      PredictionRepositoryImpl(ref.watch(predictionRemoteDataSourceProvider)),
);

final predictionUseCaseProvider = Provider<PredictionUseCase>(
  (ref) => PredictionUseCase(ref.watch(predictionRepositoryProvider)),
);

final scannerControllerProvider =
    NotifierProvider<ScannerController, ScannerState>(ScannerController.new);

/// Coordinates upload selection, validation, staged scanning, and result output.
class ScannerController extends Notifier<ScannerState> {
  static const _fileExtensions = <String>[
    'exe',
    'dll',
    'apk',
    'pdf',
    'docx',
    'zip',
    'rar',
    'bin',
  ];

  static const _imageExtensions = <String>['jpg', 'jpeg', 'png', 'bmp', 'webp'];

  PredictionUseCase get _predictionUseCase =>
      ref.read(predictionUseCaseProvider);

  SaveScanHistoryUseCase get _saveScanHistoryUseCase =>
      ref.read(saveScanHistoryUseCaseProvider);

  @override
  ScannerState build() {
    return const ScannerState();
  }

  Future<void> pickFile() async {
    await _pickAsset(ScanAssetType.file);
  }

  Future<void> pickImage() async {
    await _pickAsset(ScanAssetType.image);
  }

  Future<void> runScan() async {
    final selectedAsset = state.selectedAsset;
    if (selectedAsset == null) {
      state = state.copyWith(
        status: ScannerStatus.failure,
        errorMessage: 'Unsupported File',
        clearLatestReport: true,
        currentStageIndex: -1,
      );
      return;
    }

    state = state.copyWith(
      status: ScannerStatus.scanning,
      clearError: true,
      clearLatestReport: true,
      currentStageIndex: 0,
    );

    try {
      final predictionFuture = _predictionUseCase(selectedAsset);

      for (var index = 0; index < scannerStages.length - 1; index++) {
        state = state.copyWith(
          status: ScannerStatus.scanning,
          currentStageIndex: index,
        );
        await Future<void>.delayed(const Duration(milliseconds: 350));
      }

      final prediction = await predictionFuture;

      state = state.copyWith(
        status: ScannerStatus.scanning,
        currentStageIndex: scannerStages.length - 1,
      );

      await Future<void>.delayed(const Duration(milliseconds: 250));

      final report = ScanReportEntity(
        asset: selectedAsset,
        prediction: prediction,
        scanDate: DateTime.now(),
      );
      await _saveScanHistoryUseCase(report);

      state = state.copyWith(
        status: ScannerStatus.success,
        latestReport: report,
      );
    } on AppException catch (error) {
      state = state.copyWith(
        status: ScannerStatus.failure,
        currentStageIndex: -1,
        errorMessage: error.message,
        clearLatestReport: true,
      );
    } catch (error) {
      state = state.copyWith(
        status: ScannerStatus.failure,
        currentStageIndex: -1,
        errorMessage: 'Unexpected Error',
        clearLatestReport: true,
      );
      debugPrint('ScannerController.runScan error: $error');
    }
  }

  void clearSelection() {
    state = state.copyWith(
      status: ScannerStatus.idle,
      clearSelectedAsset: true,
      clearError: true,
      clearLatestReport: true,
      currentStageIndex: -1,
    );
  }

  void dismissError() {
    state = state.copyWith(clearError: true);
  }

  void consumeLatestReport() {
    state = state.copyWith(clearLatestReport: true);
  }

  Future<void> _pickAsset(ScanAssetType assetType) async {
    try {
      final selectedFile = await openFile(
        acceptedTypeGroups: <XTypeGroup>[
          XTypeGroup(
            label: assetType == ScanAssetType.file
                ? 'Supported files'
                : 'Supported images',
            extensions: assetType == ScanAssetType.file
                ? _fileExtensions
                : _imageExtensions,
          ),
        ],
      );

      if (selectedFile == null) {
        return;
      }

      final bytes = await selectedFile.readAsBytes();
      final fileSize = await selectedFile.length();

      if (fileSize > AppLimits.maxUploadBytes) {
        throw const AppException('Large File');
      }

      final extension = _extractExtension(selectedFile.name).toLowerCase();
      final allowedExtensions = assetType == ScanAssetType.file
          ? _fileExtensions
          : _imageExtensions;

      if (!allowedExtensions.contains(extension)) {
        throw const AppException('Unsupported File');
      }

      final asset = ScanAssetEntity(
        fileName: selectedFile.name,
        extension: extension,
        sizeInBytes: fileSize,
        sha256: sha256.convert(bytes).toString(),
        bytes: bytes,
        assetType: assetType,
      );

      state = state.copyWith(
        status: ScannerStatus.ready,
        selectedAsset: asset,
        clearError: true,
        clearLatestReport: true,
        currentStageIndex: -1,
      );
    } on AppException catch (error) {
      state = state.copyWith(
        status: ScannerStatus.failure,
        errorMessage: error.message,
        clearLatestReport: true,
      );
    } catch (error) {
      state = state.copyWith(
        status: ScannerStatus.failure,
        errorMessage: 'Unexpected Error',
        clearLatestReport: true,
      );
      debugPrint('ScannerController._pickAsset error: $error');
    }
  }

  String _extractExtension(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == fileName.length - 1) {
      return '';
    }

    return fileName.substring(dotIndex + 1);
  }
}
