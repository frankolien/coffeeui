import 'package:shared_preferences/shared_preferences.dart';
import '../../core/errors/failures.dart';

abstract class LocalDataSource {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> removeToken();
  Future<String?> getUserId();
  Future<void> saveUserId(String userId);
  Future<String?> getLocationId();
  Future<void> saveLocationId(String locationId);
  Future<void> clearAll();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences prefs;

  LocalDataSourceImpl(this.prefs);

  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _locationIdKey = 'location_id';

  @override
  Future<String?> getToken() async {
    try {
      return prefs.getString(_tokenKey);
    } catch (e) {
      throw CacheFailure('Failed to get token: $e');
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      throw CacheFailure('Failed to save token: $e');
    }
  }

  @override
  Future<void> removeToken() async {
    try {
      await prefs.remove(_tokenKey);
    } catch (e) {
      throw CacheFailure('Failed to remove token: $e');
    }
  }

  @override
  Future<String?> getUserId() async {
    try {
      return prefs.getString(_userIdKey);
    } catch (e) {
      throw CacheFailure('Failed to get user ID: $e');
    }
  }

  @override
  Future<void> saveUserId(String userId) async {
    try {
      await prefs.setString(_userIdKey, userId);
    } catch (e) {
      throw CacheFailure('Failed to save user ID: $e');
    }
  }

  @override
  Future<String?> getLocationId() async {
    try {
      return prefs.getString(_locationIdKey);
    } catch (e) {
      throw CacheFailure('Failed to get location ID: $e');
    }
  }

  @override
  Future<void> saveLocationId(String locationId) async {
    try {
      await prefs.setString(_locationIdKey, locationId);
    } catch (e) {
      throw CacheFailure('Failed to save location ID: $e');
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await prefs.clear();
    } catch (e) {
      throw CacheFailure('Failed to clear storage: $e');
    }
  }
}

