import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/utils/result.dart';
import '../../core/utils/result_extension.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/api_constants.dart';
import '../datasources/remote_data_source.dart';
import '../datasources/local_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<UserEntity>> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    try {
      final response = await remoteDataSource.post(
        ApiConstants.authRegister,
        {
          'email': email,
          'password': password,
          'fullName': fullName,
          if (phone != null) 'phone': phone,
        },
      );

      final userData = response['user'] as Map<String, dynamic>;
      final token = response['token'] as String;

      await localDataSource.saveToken(token);
      if (userData['id'] != null) {
        await localDataSource.saveUserId(userData['id'].toString());
      }

      final user = UserModel.fromJson(userData);
      return Success(user);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Registration failed: $e'));
    }
  }

  @override
  Future<Result<String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.post(
        ApiConstants.authLogin,
        {
          'email': email,
          'password': password,
        },
      );

      final token = response['token'] as String;
      final userData = response['user'] as Map<String, dynamic>;

      await localDataSource.saveToken(token);
      if (userData['id'] != null) {
        await localDataSource.saveUserId(userData['id'].toString());
      }

      return Success(token);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(AuthenticationFailure('Login failed: $e'));
    }
  }

  @override
  Future<Result<UserEntity>> getCurrentUser() async {
    try {
      final token = await localDataSource.getToken();
      if (token == null) {
        return Error(AuthenticationFailure('No token found'));
      }

      final headers = {'Authorization': 'Bearer $token'};
      final response = await remoteDataSource.get(
        ApiConstants.authMe,
        headers: headers,
      );

      final user = UserModel.fromJson(response);
      return Success(user);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(AuthenticationFailure('Failed to get user: $e'));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await localDataSource.clearAll();
      return const Success(null);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(CacheFailure('Logout failed: $e'));
    }
  }
}

