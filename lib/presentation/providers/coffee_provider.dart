import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/coffee_type_entity.dart';
import '../../domain/repositories/coffee_repository.dart';
import '../../core/utils/result_extension.dart';
import '../../core/di/dependency_injection.dart';

final coffeeRepositoryProvider = Provider<CoffeeRepository>((ref) {
  return ref.watch(coffeeRepositoryProviderOverride);
});

final coffeeListProvider = FutureProvider.autoDispose<List<CoffeeTypeEntity>>((ref) async {
  final repository = ref.read(coffeeRepositoryProvider);
  final result = await repository.getCoffeeTypes();
  return result.when(
    success: (coffees) => coffees,
    error: (failure) => throw Exception(failure.message),
  );
});

final coffeeListFilteredProvider = FutureProvider.autoDispose.family<List<CoffeeTypeEntity>, CoffeeFilters>((ref, filters) async {
  final repository = ref.read(coffeeRepositoryProvider);
  final result = await repository.getCoffeeTypes(
    search: filters.search,
    availableOnly: filters.availableOnly,
    minPrice: filters.minPrice,
    maxPrice: filters.maxPrice,
    sortBy: filters.sortBy,
    sortOrder: filters.sortOrder,
  );
  return result.when(
    success: (coffees) => coffees,
    error: (failure) => throw Exception(failure.message),
  );
});

final coffeeByIdProvider = FutureProvider.autoDispose.family<CoffeeTypeEntity, String>((ref, id) async {
  final repository = ref.read(coffeeRepositoryProvider);
  final result = await repository.getCoffeeTypeById(id);
  return result.when(
    success: (coffee) => coffee,
    error: (failure) => throw Exception(failure.message),
  );
});

class CoffeeFilters {
  final String? search;
  final bool? availableOnly;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? sortOrder;

  const CoffeeFilters({
    this.search,
    this.availableOnly,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
    this.sortOrder,
  });

  CoffeeFilters copyWith({
    String? search,
    bool? availableOnly,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? sortOrder,
  }) {
    return CoffeeFilters(
      search: search ?? this.search,
      availableOnly: availableOnly ?? this.availableOnly,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CoffeeFilters &&
        other.search == search &&
        other.availableOnly == availableOnly &&
        other.minPrice == minPrice &&
        other.maxPrice == maxPrice &&
        other.sortBy == sortBy &&
        other.sortOrder == sortOrder;
  }

  @override
  int get hashCode {
    return Object.hash(
      search,
      availableOnly,
      minPrice,
      maxPrice,
      sortBy,
      sortOrder,
    );
  }
}

