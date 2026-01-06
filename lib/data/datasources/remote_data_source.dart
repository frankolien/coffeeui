import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/errors/failures.dart';

abstract class RemoteDataSource {
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers});
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers});
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers});
  Future<void> delete(String endpoint, {Map<String, String>? headers});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  final String baseUrl;

  RemoteDataSourceImpl({
    required this.client,
    this.baseUrl = ApiConstants.baseUrl,
  });

  Map<String, String> _getHeaders({String? token}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  @override
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final url = '$baseUrl$endpoint';
      print('🌐 Making GET request to: $url');
      final response = await client.get(
        Uri.parse(url),
        headers: headers ?? _getHeaders(),
      );

      print('📡 Response status: ${response.statusCode}');
      print('📄 Response body length: ${response.body.length}');

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        print('✅ Response decoded successfully');
        if (decoded is List) {
          return {'data': decoded};
        }
        return decoded as Map<String, dynamic>;
      } else {
        print('❌ Error status: ${response.statusCode}');
        print('❌ Error body: ${response.body}');
        throw ServerFailure('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception in get: $e');
      if (e is Failure) rethrow;
      throw NetworkFailure('Network error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ?? _getHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw ServerFailure('Failed to create: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw NetworkFailure('Network error: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ?? _getHeaders(),
        body: json.encode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw ServerFailure('Failed to update: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw NetworkFailure('Network error: $e');
    }
  }

  @override
  Future<void> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ?? _getHeaders(),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerFailure('Failed to delete: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw NetworkFailure('Network error: $e');
    }
  }
}

