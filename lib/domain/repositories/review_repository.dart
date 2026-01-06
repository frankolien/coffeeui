import '../entities/review_entity.dart';
import '../../core/utils/result.dart';

abstract class ReviewRepository {
  Future<Result<List<ReviewEntity>>> getReviews();

  Future<Result<List<ReviewEntity>>> getReviewsByCoffeeType(String coffeeTypeID);

  Future<Result<List<ReviewEntity>>> getReviewsByLocation(String locationID);

  Future<Result<ReviewEntity>> createReview({
    String? coffeeTypeID,
    String? locationID,
    required int rating,
    String? comment,
  });

  Future<Result<ReviewEntity>> updateReview({
    required String id,
    int? rating,
    String? comment,
  });

  Future<Result<void>> deleteReview(String id);
}

