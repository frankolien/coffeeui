import '../../domain/entities/coffee_type_entity.dart';
import '../../domain/repositories/coffee_repository.dart';
import '../../core/utils/result.dart';
import '../../core/utils/result_extension.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/api_constants.dart';
import '../datasources/remote_data_source.dart';
import '../datasources/local_data_source.dart';
import '../models/coffee_type_model.dart';

class CoffeeRepositoryImpl implements CoffeeRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  CoffeeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });


  @override
  Future<Result<List<CoffeeTypeEntity>>> getCoffeeTypes({
    String? search,
    bool? availableOnly,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (search != null) queryParams['search'] = search;
      if (availableOnly != null) queryParams['available'] = availableOnly.toString();
      if (minPrice != null) queryParams['minPrice'] = minPrice.toString();
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice.toString();
      if (sortBy != null) queryParams['sortBy'] = sortBy;
      if (sortOrder != null) queryParams['sortOrder'] = sortOrder;

      String endpoint = ApiConstants.coffeeTypes;
      if (queryParams.isNotEmpty) {
        endpoint += '?${Uri(queryParameters: queryParams).query}';
      }

      print('🔍 Fetching coffee from: $endpoint');
      final response = await remoteDataSource.get(endpoint);
      print('📦 Response received: ${response.keys}');
      
      final List<dynamic> data = (response['data'] as List<dynamic>?) ?? 
          ((response is List) ? response as List<dynamic> : []);
      print('📊 Data items: ${data.length}');
      
      final coffeeTypes = data
          .map((json) => CoffeeTypeModel.fromJson(json as Map<String, dynamic>))
          .toList();

      print('✅ Coffee types parsed: ${coffeeTypes.length}');
      return Success(coffeeTypes);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get coffee types: $e'));
    }
  }

  @override
  Future<Result<CoffeeTypeEntity>> getCoffeeTypeById(String id) async {
    try {
      final response = await remoteDataSource.get(ApiConstants.coffeeTypeById(id));
      final coffeeType = CoffeeTypeModel.fromJson(response);
      return Success(coffeeType);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get coffee type: $e'));
    }
  }
}

