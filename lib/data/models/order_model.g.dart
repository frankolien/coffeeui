// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String,
  userID: json['userID'] as String,
  coffeeTypeID: json['coffeeTypeID'] as String,
  coffeeTypeName: json['coffeeTypeName'] as String?,
  locationID: json['locationID'] as String,
  locationName: json['locationName'] as String?,
  quantity: (json['quantity'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num).toDouble(),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  size: json['size'] as String?,
  milkType: json['milkType'] as String?,
  extras: json['extras'] as String?,
  specialInstructions: json['specialInstructions'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'coffeeTypeID': instance.coffeeTypeID,
      'coffeeTypeName': instance.coffeeTypeName,
      'locationID': instance.locationID,
      'locationName': instance.locationName,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'size': instance.size,
      'milkType': instance.milkType,
      'extras': instance.extras,
      'specialInstructions': instance.specialInstructions,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.confirmed: 'confirmed',
  OrderStatus.preparing: 'preparing',
  OrderStatus.ready: 'ready',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
