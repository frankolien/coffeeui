import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/review_repository.dart';
import '../../core/utils/result.dart';
import '../../core/utils/result_extension.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/api_constants.dart';
import '../datasources/remote_data_source.dart';
import '../datasources/local_data_source.dart';
import '../models/review_model.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  ReviewRepositoryImpl({
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
  Future<Result<List<ReviewEntity>>> getReviews() async {
    try {
      final response = await remoteDataSource.get(ApiConstants.reviews);
      
      final List<dynamic> data = (response['data'] as List<dynamic>?) ?? 
          ((response is List) ? response as List<dynamic> : []);
      final reviews = data
          .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Success(reviews);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get reviews: $e'));
    }
  }

  @override
  Future<Result<List<ReviewEntity>>> getReviewsByCoffeeType(String coffeeTypeID) async {
    try {
      final response = await remoteDataSource.get(ApiConstants.reviewsByCoffeeType(coffeeTypeID));
      
      final List<dynamic> data = (response['data'] as List<dynamic>?) ?? 
          ((response is List) ? response as List<dynamic> : []);
      final reviews = data
          .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Success(reviews);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get reviews: $e'));
    }
  }

  @override
  Future<Result<List<ReviewEntity>>> getReviewsByLocation(String locationID) async {
    try {
      final response = await remoteDataSource.get(ApiConstants.reviewsByLocation(locationID));
      
      final List<dynamic> data = (response['data'] as List<dynamic>?) ?? 
          ((response is List) ? response as List<dynamic> : []);
      final reviews = data
          .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Success(reviews);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get reviews: $e'));
    }
  }

  @override
  Future<Result<ReviewEntity>> createReview({
    String? coffeeTypeID,
    String? locationID,
    required int rating,
    String? comment,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.post(
        ApiConstants.reviews,
        {
          if (coffeeTypeID != null) 'coffeeTypeID': coffeeTypeID,
          if (locationID != null) 'locationID': locationID,
          'rating': rating,
          if (comment != null) 'comment': comment,
        },
        headers: headers,
      );

      final review = ReviewModel.fromJson(response);
      return Success(review);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to create review: $e'));
    }
  }

  @override
  Future<Result<ReviewEntity>> updateReview({
    required String id,
    int? rating,
    String? comment,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.put(
        '${ApiConstants.reviews}/$id',
        {
          if (rating != null) 'rating': rating,
          if (comment != null) 'comment': comment,
        },
        headers: headers,
      );

      final review = ReviewModel.fromJson(response);
      return Success(review);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to update review: $e'));
    }
  }

  @override
  Future<Result<void>> deleteReview(String id) async {
    try {
      final headers = await _getHeaders();
      await remoteDataSource.delete('${ApiConstants.reviews}/$id', headers: headers);
      return const Success(null);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to delete review: $e'));
    }
  }
}

