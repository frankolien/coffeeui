import '../entities/order_entity.dart';
import '../../core/utils/result.dart';

abstract class OrderRepository {
  Future<Result<List<OrderEntity>>> getOrders();

  Future<Result<List<OrderEntity>>> getMyOrders();

  Future<Result<OrderEntity>> getOrderById(String id);

  Future<Result<OrderEntity>> createOrder({
    required String coffeeTypeID,
    required String locationID,
    required int quantity,
    String? size,
    String? milkType,
    String? extras,
    String? specialInstructions,
  });

  Future<Result<OrderEntity>> updateOrder({
    required String id,
    String? size,
    String? milkType,
    String? extras,
    String? specialInstructions,
  });

  Future<Result<void>> deleteOrder(String id);
}

