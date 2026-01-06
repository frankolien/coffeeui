// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeeTypeModel _$CoffeeTypeModelFromJson(Map<String, dynamic> json) =>
    CoffeeTypeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      imageURL: json['imageURL'] as String?,
      isAvailable: json['isAvailable'] as bool,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CoffeeTypeModelToJson(CoffeeTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageURL': instance.imageURL,
      'isAvailable': instance.isAvailable,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
