import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../../core/utils/result_extension.dart';

import '../../core/di/dependency_injection.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return ref.watch(orderRepositoryProviderOverride);
});

final orderListProvider = FutureProvider.autoDispose<List<OrderEntity>>((ref) async {
  final repository = ref.read(orderRepositoryProvider);
  final result = await repository.getOrders();
  return result.when(
    success: (orders) => orders,
    error: (failure) => throw Exception(failure.message),
  );
});

final myOrdersProvider = FutureProvider.autoDispose<List<OrderEntity>>((ref) async {
  final repository = ref.read(orderRepositoryProvider);
  final result = await repository.getMyOrders();
  return result.when(
    success: (orders) => orders,
    error: (failure) => throw Exception(failure.message),
  );
});

final orderByIdProvider = FutureProvider.autoDispose.family<OrderEntity, String>((ref, id) async {
  final repository = ref.read(orderRepositoryProvider);
  final result = await repository.getOrderById(id);
  return result.when(
    success: (order) => order,
    error: (failure) => throw Exception(failure.message),
  );
});

final orderNotifierProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier(ref.read(orderRepositoryProvider));
});

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepository _repository;

  OrderNotifier(this._repository) : super(OrderState.initial());

  Future<void> createOrder({
    required String coffeeTypeID,
    required String locationID,
    required int quantity,
    String? size,
    String? milkType,
    String? extras,
    String? specialInstructions,
  }) async {
    state = OrderState.loading();
    final result = await _repository.createOrder(
      coffeeTypeID: coffeeTypeID,
      locationID: locationID,
      quantity: quantity,
      size: size,
      milkType: milkType,
      extras: extras,
      specialInstructions: specialInstructions,
    );
    result.when(
      success: (order) => state = OrderState.success(order),
      error: (failure) => state = OrderState.error(failure.message),
    );
  }

  Future<void> updateOrder({
    required String id,
    String? size,
    String? milkType,
    String? extras,
    String? specialInstructions,
  }) async {
    state = OrderState.loading();
    final result = await _repository.updateOrder(
      id: id,
      size: size,
      milkType: milkType,
      extras: extras,
      specialInstructions: specialInstructions,
    );
    result.when(
      success: (order) => state = OrderState.success(order),
      error: (failure) => state = OrderState.error(failure.message),
    );
  }

  Future<void> deleteOrder(String id) async {
    state = OrderState.loading();
    final result = await _repository.deleteOrder(id);
    result.when(
      success: (_) => state = OrderState.deleted(),
      error: (failure) => state = OrderState.error(failure.message),
    );
  }

  void reset() {
    state = OrderState.initial();
  }
}

class OrderState {
  final bool isLoading;
  final OrderEntity? order;
  final String? error;
  final bool isDeleted;

  const OrderState({
    required this.isLoading,
    this.order,
    this.error,
    required this.isDeleted,
  });

  factory OrderState.initial() => const OrderState(
        isLoading: false,
        isDeleted: false,
      );

  factory OrderState.loading() => const OrderState(
        isLoading: true,
        isDeleted: false,
      );

  factory OrderState.success(OrderEntity order) => OrderState(
        isLoading: false,
        order: order,
        isDeleted: false,
      );

  factory OrderState.error(String error) => OrderState(
        isLoading: false,
        error: error,
        isDeleted: false,
      );

  factory OrderState.deleted() => const OrderState(
        isLoading: false,
        isDeleted: true,
      );
}

