import 'package:equatable/equatable.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  completed,
  cancelled,
}

class OrderEntity extends Equatable {
  final String id;
  final String userID;
  final String coffeeTypeID;
  final String? coffeeTypeName;
  final String locationID;
  final String? locationName;
  final int quantity;
  final double totalPrice;
  final OrderStatus status;
  final String? size;
  final String? milkType;
  final String? extras;
  final String? specialInstructions;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderEntity({
    required this.id,
    required this.userID,
    required this.coffeeTypeID,
    this.coffeeTypeName,
    required this.locationID,
    this.locationName,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    this.size,
    this.milkType,
    this.extras,
    this.specialInstructions,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userID,
        coffeeTypeID,
        coffeeTypeName,
        locationID,
        locationName,
        quantity,
        totalPrice,
        status,
        size,
        milkType,
        extras,
        specialInstructions,
        createdAt,
        updatedAt,
      ];
}

