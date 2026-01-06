import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/remote_data_source.dart';
import '../../data/datasources/local_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/coffee_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/review_repository_impl.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/coffee_repository.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/review_repository.dart';
import '../../domain/repositories/favorite_repository.dart';

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  if (prefs == null) {
    throw Exception('SharedPreferences not initialized');
  }
  return LocalDataSourceImpl(prefs);
});

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  return RemoteDataSourceImpl(client: client);
});

final authRepositoryProviderOverride = Provider<AuthRepository>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  final local = ref.watch(localDataSourceProvider);
  return AuthRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
  );
});

final coffeeRepositoryProviderOverride = Provider<CoffeeRepository>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  final local = ref.watch(localDataSourceProvider);
  return CoffeeRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
  );
});

final locationRepositoryProviderOverride = Provider<LocationRepository>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  return LocationRepositoryImpl(remoteDataSource: remote);
});

final orderRepositoryProviderOverride = Provider<OrderRepository>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  final local = ref.watch(localDataSourceProvider);
  return OrderRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
  );
});

final reviewRepositoryProviderOverride = Provider<ReviewRepository>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  final local = ref.watch(localDataSourceProvider);
  return ReviewRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
  );
});

final favoriteRepositoryProviderOverride = Provider<FavoriteRepository>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  final local = ref.watch(localDataSourceProvider);
  return FavoriteRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
  );
});


