import '../../domain/entities/prediction_entity.dart';
import '../../domain/entities/scan_asset_entity.dart';
import '../../domain/repositories/prediction_repository.dart';
import '../datasources/prediction_remote_data_source.dart';

/// Repository implementation backed by the remote prediction data source.
class PredictionRepositoryImpl implements PredictionRepository {
  /// Creates a repository implementation.
  const PredictionRepositoryImpl(this._remoteDataSource);

  final PredictionRemoteDataSource _remoteDataSource;

  @override
  Future<PredictionEntity> predict(ScanAssetEntity asset) {
    return _remoteDataSource.predict(asset);
  }
}
