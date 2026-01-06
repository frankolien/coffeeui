import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../../core/utils/result.dart';
import '../../core/utils/result_extension.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/api_constants.dart';
import '../datasources/remote_data_source.dart';
import '../datasources/local_data_source.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Map<String, String>> _getHeaders() async {
    final token = await localDataSource.getToken();
    if (token == null) {
      throw AuthenticationFailure('No token found');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<Result<List<OrderEntity>>> getOrders() async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.get(ApiConstants.orders, headers: headers);
      
      final List<dynamic> data = (response['data'] as List<dynamic>?) ?? 
          ((response is List) ? response as List<dynamic> : []);
      final orders = data
          .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Success(orders);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get orders: $e'));
    }
  }

  @override
  Future<Result<List<OrderEntity>>> getMyOrders() async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.get(ApiConstants.myOrders, headers: headers);
      
      final List<dynamic> data = (response['data'] as List<dynamic>?) ?? 
          ((response is List) ? response as List<dynamic> : []);
      final orders = data
          .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Success(orders);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get my orders: $e'));
    }
  }

  @override
  Future<Result<OrderEntity>> getOrderById(String id) async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.get(ApiConstants.orderById(id), headers: headers);
      final order = OrderModel.fromJson(response);
      return Success(order);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to get order: $e'));
    }
  }

  @override
  Future<Result<OrderEntity>> createOrder({
    required String coffeeTypeID,
    required String locationID,
    required int quantity,
    String? size,
    String? milkType,
    String? extras,
    String? specialInstructions,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.post(
        ApiConstants.orders,
        {
          'coffeeTypeID': coffeeTypeID,
          'locationID': locationID,
          'quantity': quantity,
          if (size != null) 'size': size,
          if (milkType != null) 'milkType': milkType,
          if (extras != null) 'extras': extras,
          if (specialInstructions != null) 'specialInstructions': specialInstructions,
        },
        headers: headers,
      );

      final order = OrderModel.fromJson(response);
      return Success(order);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to create order: $e'));
    }
  }

  @override
  Future<Result<OrderEntity>> updateOrder({
    required String id,
    String? size,
    String? milkType,
    String? extras,
    String? specialInstructions,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await remoteDataSource.put(
        ApiConstants.orderById(id),
        {
          if (size != null) 'size': size,
          if (milkType != null) 'milkType': milkType,
          if (extras != null) 'extras': extras,
          if (specialInstructions != null) 'specialInstructions': specialInstructions,
        },
        headers: headers,
      );

      final order = OrderModel.fromJson(response);
      return Success(order);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to update order: $e'));
    }
  }

  @override
  Future<Result<void>> deleteOrder(String id) async {
    try {
      final headers = await _getHeaders();
      await remoteDataSource.delete(ApiConstants.orderById(id), headers: headers);
      return const Success(null);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(ServerFailure('Failed to delete order: $e'));
    }
  }
}

