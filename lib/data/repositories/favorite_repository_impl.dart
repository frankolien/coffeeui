import '../../domain/entities/coffee_type_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../core/utils/result.dart';
import '../../core/utils/result_extension.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/api_constants.dart';
import '../datasources/remote_data_source.dart';
import '../datasources/local_data_source.dart';
import '../models/coffee_type_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  FavoriteRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Map<String, String>> _getHeaders() async {
    final token = await localDataSource.getToken();
    if (token == null) {
      throw AuthenticationFailure('No token found');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<Result<List<CoffeeTypeEntity>>> getFavorites() async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.get(ApiConstants.favorites, headers: headers);
      
      final List<dynamic> data = (response['data'] as List<dynamic>?) ?? 
          ((response is List) ? response as List<dynamic> : []);
      final favorites = data
          .map((json) {
            final coffeeTypeJson = json['coffeeType'] as Map<String, dynamic>? ?? json;
            return CoffeeTypeModel.fromJson(coffeeTypeJson);
          })
          .toList();

      return Success(favorites);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get favorites: $e'));
    }
  }

  @override
  Future<Result<bool>> isFavorite(String coffeeTypeID) async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.get(
        '${ApiConstants.favorites}/$coffeeTypeID',
        headers: headers,
      );
      
      final isFavorite = response['isFavorite'] as bool? ?? false;
      return Success(isFavorite);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to check favorite: $e'));
    }
  }

  @override
  Future<Result<void>> addFavorite(String coffeeTypeID) async {
    try {
      final headers = await _getHeaders();
      await remoteDataSource.post(
        '${ApiConstants.favorites}/$coffeeTypeID',
        {},
        headers: headers,
      );
      return const Success(null);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to add favorite: $e'));
    }
  }

  @override
  Future<Result<void>> removeFavorite(String coffeeTypeID) async {
    try {
      final headers = await _getHeaders();
      await remoteDataSource.delete(
        '${ApiConstants.favorites}/$coffeeTypeID',
        headers: headers,
      );
      return const Success(null);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to remove favorite: $e'));
    }
  }
}

