import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../../core/utils/result.dart';
import '../../core/utils/result_extension.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/api_constants.dart';
import '../datasources/remote_data_source.dart';
import '../models/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final RemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<LocationEntity>>> getLocations({bool? activeOnly}) async {
    try {
      String endpoint = ApiConstants.locations;
      if (activeOnly != null) {
        endpoint += '?active=$activeOnly';
      }

      final response = await remoteDataSource.get(endpoint);
      
      final List<dynamic> data = (response['data'] as List<dynamic>?) ?? 
          ((response is List) ? response as List<dynamic> : []);
      final locations = data
          .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Success(locations);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get locations: $e'));
    }
  }

  @override
  Future<Result<LocationEntity>> getLocationById(String id) async {
    try {
      final response = await remoteDataSource.get(ApiConstants.locationById(id));
      final location = LocationModel.fromJson(response);
      return Success(location);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get location: $e'));
    }
  }
}

