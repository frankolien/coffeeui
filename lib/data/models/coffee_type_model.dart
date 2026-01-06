import '../../domain/entities/coffee_type_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coffee_type_model.g.dart';

@JsonSerializable()
class CoffeeTypeModel extends CoffeeTypeEntity {
  const CoffeeTypeModel({
    required super.id,
    required super.name,
    super.description,
    required super.price,
    super.imageURL,
    required super.isAvailable,
    super.createdAt,
    super.updatedAt,
  });

  factory CoffeeTypeModel.fromJson(Map<String, dynamic> json) => _$CoffeeTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeTypeModelToJson(this);

  factory CoffeeTypeModel.fromEntity(CoffeeTypeEntity entity) => CoffeeTypeModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        price: entity.price,
        imageURL: entity.imageURL,
        isAvailable: entity.isAvailable,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

