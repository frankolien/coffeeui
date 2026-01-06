import '../entities/coffee_type_entity.dart';
import '../../core/utils/result.dart';

abstract class CoffeeRepository {
  Future<Result<List<CoffeeTypeEntity>>> getCoffeeTypes({
    String? search,
    bool? availableOnly,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? sortOrder,
  });

  Future<Result<CoffeeTypeEntity>> getCoffeeTypeById(String id);
}

