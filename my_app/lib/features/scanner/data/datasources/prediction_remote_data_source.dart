import 'package:dio/dio.dart';

import '../../../../core/network/app_exception.dart';
import '../../domain/entities/scan_asset_entity.dart';
import '../models/prediction_model.dart';
import '../services/prediction_service.dart';

/// Remote data source for model inference requests.
class PredictionRemoteDataSource {
  /// Creates a prediction data source.
  const PredictionRemoteDataSource(this._service);

  final PredictionService _service;

  /// Executes the remote prediction flow and maps transport failures.
  Future<PredictionModel> predict(ScanAssetEntity asset) async {
    try {
      final response = await _service.predict(asset);
      return PredictionModel.fromJson(response);
    } on DioException catch (error) {
      throw AppException(_mapDioError(error));
    } catch (error) {
      if (error is AppException) {
        rethrow;
      }

      throw const AppException('Unexpected Error');
    }
  }

  String _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Timeout';
      case DioExceptionType.connectionError:
        return 'No Internet';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 500;
        if (statusCode == 403) {
          return 'Permission Denied';
        }
        return 'Server Error';
      default:
        return 'Prediction Failed';
    }
  }
}
