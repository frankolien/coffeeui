import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/review_repository.dart';
import '../../core/utils/result_extension.dart';

import '../../core/di/dependency_injection.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ref.watch(reviewRepositoryProviderOverride);
});

final reviewListProvider = FutureProvider.autoDispose<List<ReviewEntity>>((ref) async {
  final repository = ref.read(reviewRepositoryProvider);
  final result = await repository.getReviews();
  return result.when(
    success: (reviews) => reviews,
    error: (failure) => throw Exception(failure.message),
  );
});

final reviewsByCoffeeTypeProvider = FutureProvider.autoDispose.family<List<ReviewEntity>, String>((ref, coffeeTypeID) async {
  final repository = ref.read(reviewRepositoryProvider);
  final result = await repository.getReviewsByCoffeeType(coffeeTypeID);
  return result.when(
    success: (reviews) => reviews,
    error: (failure) => throw Exception(failure.message),
  );
});

final reviewsByLocationProvider = FutureProvider.autoDispose.family<List<ReviewEntity>, String>((ref, locationID) async {
  final repository = ref.read(reviewRepositoryProvider);
  final result = await repository.getReviewsByLocation(locationID);
  return result.when(
    success: (reviews) => reviews,
    error: (failure) => throw Exception(failure.message),
  );
});

final reviewNotifierProvider = StateNotifierProvider<ReviewNotifier, ReviewState>((ref) {
  return ReviewNotifier(ref.read(reviewRepositoryProvider));
});

class ReviewNotifier extends StateNotifier<ReviewState> {
  final ReviewRepository _repository;

  ReviewNotifier(this._repository) : super(ReviewState.initial());

  Future<void> createReview({
    String? coffeeTypeID,
    String? locationID,
    required int rating,
    String? comment,
  }) async {
    state = ReviewState.loading();
    final result = await _repository.createReview(
      coffeeTypeID: coffeeTypeID,
      locationID: locationID,
      rating: rating,
      comment: comment,
    );
    result.when(
      success: (review) => state = ReviewState.success(review),
      error: (failure) => state = ReviewState.error(failure.message),
    );
  }

  Future<void> deleteReview(String id) async {
    state = ReviewState.loading();
    final result = await _repository.deleteReview(id);
    result.when(
      success: (_) => state = ReviewState.deleted(),
      error: (failure) => state = ReviewState.error(failure.message),
    );
  }

  void reset() {
    state = ReviewState.initial();
  }
}

class ReviewState {
  final bool isLoading;
  final ReviewEntity? review;
  final String? error;
  final bool isDeleted;

  const ReviewState({
    required this.isLoading,
    this.review,
    this.error,
    required this.isDeleted,
  });

  factory ReviewState.initial() => const ReviewState(
        isLoading: false,
        isDeleted: false,
      );

  factory ReviewState.loading() => const ReviewState(
        isLoading: true,
        isDeleted: false,
      );

  factory ReviewState.success(ReviewEntity review) => ReviewState(
        isLoading: false,
        review: review,
        isDeleted: false,
      );

  factory ReviewState.error(String error) => ReviewState(
        isLoading: false,
        error: error,
        isDeleted: false,
      );

  factory ReviewState.deleted() => const ReviewState(
        isLoading: false,
        isDeleted: true,
      );
}

