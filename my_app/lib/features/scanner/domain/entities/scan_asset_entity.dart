import 'dart:typed_data';

/// Supported asset sources for the prediction workflow.
enum ScanAssetType { file, image }

/// Immutable representation of the selected asset to be scanned.
class ScanAssetEntity {
  /// Creates a scan asset entity.
  const ScanAssetEntity({
    required this.fileName,
    required this.extension,
    required this.sizeInBytes,
    required this.sha256,
    required this.bytes,
    required this.assetType,
  });

  final String fileName;
  final String extension;
  final int sizeInBytes;
  final String sha256;
  final Uint8List bytes;
  final ScanAssetType assetType;

  bool get isImage => assetType == ScanAssetType.image;
}
