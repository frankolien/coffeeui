import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../../core/utils/result_extension.dart';
import '../../core/di/dependency_injection.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return ref.watch(locationRepositoryProviderOverride);
});

final locationListProvider = FutureProvider.autoDispose<List<LocationEntity>>((ref) async {
  final repository = ref.read(locationRepositoryProvider);
  final result = await repository.getLocations();
  return result.when(
    success: (locations) => locations,
    error: (failure) => throw Exception(failure.message),
  );
});

final locationListActiveProvider = FutureProvider.autoDispose<List<LocationEntity>>((ref) async {
  final repository = ref.read(locationRepositoryProvider);
  final result = await repository.getLocations(activeOnly: true);
  return result.when(
    success: (locations) => locations,
    error: (failure) => throw Exception(failure.message),
  );
});

final locationByIdProvider = FutureProvider.autoDispose.family<LocationEntity, String>((ref, id) async {
  final repository = ref.read(locationRepositoryProvider);
  final result = await repository.getLocationById(id);
  return result.when(
    success: (location) => location,
    error: (failure) => throw Exception(failure.message),
  );
});

