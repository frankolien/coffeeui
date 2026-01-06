import '../entities/user_entity.dart';
import '../../core/utils/result.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  });

  Future<Result<String>> login({
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> getCurrentUser();

  Future<Result<void>> logout();
}

