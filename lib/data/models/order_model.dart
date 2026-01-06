import '../../domain/entities/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userID,
    required super.coffeeTypeID,
    super.coffeeTypeName,
    required super.locationID,
    super.locationName,
    required super.quantity,
    required super.totalPrice,
    required super.status,
    super.size,
    super.milkType,
    super.extras,
    super.specialInstructions,
    super.createdAt,
    super.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  factory OrderModel.fromEntity(OrderEntity entity) => OrderModel(
        id: entity.id,
        userID: entity.userID,
        coffeeTypeID: entity.coffeeTypeID,
        coffeeTypeName: entity.coffeeTypeName,
        locationID: entity.locationID,
        locationName: entity.locationName,
        quantity: entity.quantity,
        totalPrice: entity.totalPrice,
        status: entity.status,
        size: entity.size,
        milkType: entity.milkType,
        extras: entity.extras,
        specialInstructions: entity.specialInstructions,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

