import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/coffee_type_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../core/utils/result_extension.dart';
import '../../core/di/dependency_injection.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return ref.watch(favoriteRepositoryProviderOverride);
});

final favoriteListProvider = FutureProvider.autoDispose<List<CoffeeTypeEntity>>((ref) async {
  final repository = ref.read(favoriteRepositoryProvider);
  final result = await repository.getFavorites();
  return result.when(
    success: (favorites) => favorites,
    error: (failure) => throw Exception(failure.message),
  );
});

final isFavoriteProvider = FutureProvider.autoDispose.family<bool, String>((ref, coffeeTypeID) async {
  final repository = ref.read(favoriteRepositoryProvider);
  final result = await repository.isFavorite(coffeeTypeID);
  return result.when(
    success: (isFavorite) => isFavorite,
    error: (_) => false,
  );
});

final favoriteNotifierProvider = StateNotifierProvider<FavoriteNotifier, FavoriteState>((ref) {
  return FavoriteNotifier(ref.read(favoriteRepositoryProvider));
});

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final FavoriteRepository _repository;

  FavoriteNotifier(this._repository) : super(FavoriteState.initial());

  Future<void> toggleFavorite(String coffeeTypeID) async {
    final isFavoriteResult = await _repository.isFavorite(coffeeTypeID);
    final currentIsFavorite = isFavoriteResult.when(
      success: (value) => value,
      error: (_) => false,
    );

    if (currentIsFavorite) {
      await removeFavorite(coffeeTypeID);
    } else {
      await addFavorite(coffeeTypeID);
    }
  }

  Future<void> addFavorite(String coffeeTypeID) async {
    state = FavoriteState.loading();
    final result = await _repository.addFavorite(coffeeTypeID);
    result.when(
      success: (_) => state = FavoriteState.success(),
      error: (failure) => state = FavoriteState.error(failure.message),
    );
  }

  Future<void> removeFavorite(String coffeeTypeID) async {
    state = FavoriteState.loading();
    final result = await _repository.removeFavorite(coffeeTypeID);
    result.when(
      success: (_) => state = FavoriteState.success(),
      error: (failure) => state = FavoriteState.error(failure.message),
    );
  }

  void reset() {
    state = FavoriteState.initial();
  }
}

class FavoriteState {
  final bool isLoading;
  final String? error;

  const FavoriteState({
    required this.isLoading,
    this.error,
  });

  factory FavoriteState.initial() => const FavoriteState(isLoading: false);

  factory FavoriteState.loading() => const FavoriteState(isLoading: true);

  factory FavoriteState.success() => const FavoriteState(isLoading: false);

  factory FavoriteState.error(String error) => FavoriteState(
        isLoading: false,
        error: error,
      );
}

