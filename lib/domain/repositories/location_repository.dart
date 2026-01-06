import '../entities/location_entity.dart';
import '../../core/utils/result.dart';

abstract class LocationRepository {
  Future<Result<List<LocationEntity>>> getLocations({bool? activeOnly});

  Future<Result<LocationEntity>> getLocationById(String id);
}

