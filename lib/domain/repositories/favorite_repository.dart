import '../entities/coffee_type_entity.dart';
import '../../core/utils/result.dart';

abstract class FavoriteRepository {
  Future<Result<List<CoffeeTypeEntity>>> getFavorites();

  Future<Result<bool>> isFavorite(String coffeeTypeID);

  Future<Result<void>> addFavorite(String coffeeTypeID);

  Future<Result<void>> removeFavorite(String coffeeTypeID);
}

