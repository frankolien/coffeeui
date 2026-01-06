import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/utils/result_extension.dart';
import '../../core/di/dependency_injection.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return ref.watch(authRepositoryProviderOverride);
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.initial()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    final result = await _repository.getCurrentUser();
    result.when(
      success: (user) => state = AuthState.authenticated(user),
      error: (_) => state = AuthState.unauthenticated(),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    state = AuthState.loading();
    final result = await _repository.register(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
    );
    result.when(
      success: (user) => state = AuthState.authenticated(user),
      error: (failure) => state = AuthState.error(failure.message),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();
    final result = await _repository.login(email: email, password: password);
    result.when(
      success: (_) async {
        final userResult = await _repository.getCurrentUser();
        userResult.when(
          success: (user) => state = AuthState.authenticated(user),
          error: (failure) => state = AuthState.error(failure.message),
        );
      },
      error: (failure) => state = AuthState.error(failure.message),
    );
  }

  Future<void> logout() async {
    final result = await _repository.logout();
    result.when(
      success: (_) => state = AuthState.unauthenticated(),
      error: (failure) => state = AuthState.error(failure.message),
    );
  }
}

class AuthState {
  final bool isLoading;
  final UserEntity? user;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    required this.isLoading,
    this.user,
    this.error,
    required this.isAuthenticated,
  });

  factory AuthState.initial() => const AuthState(
        isLoading: true,
        isAuthenticated: false,
      );

  factory AuthState.loading() => const AuthState(
        isLoading: true,
        isAuthenticated: false,
      );

  factory AuthState.authenticated(UserEntity user) => AuthState(
        isLoading: false,
        user: user,
        isAuthenticated: true,
      );

  factory AuthState.unauthenticated() => const AuthState(
        isLoading: false,
        isAuthenticated: false,
      );

  factory AuthState.error(String error) => AuthState(
        isLoading: false,
        error: error,
        isAuthenticated: false,
      );
}

