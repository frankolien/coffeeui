import '../../domain/entities/location_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends LocationEntity {
  const LocationModel({
    required super.id,
    required super.name,
    required super.address,
    required super.city,
    super.state,
    super.zipCode,
    required super.country,
    super.latitude,
    super.longitude,
    super.phone,
    required super.isActive,
    super.createdAt,
    super.updatedAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  factory LocationModel.fromEntity(LocationEntity entity) => LocationModel(
        id: entity.id,
        name: entity.name,
        address: entity.address,
        city: entity.city,
        state: entity.state,
        zipCode: entity.zipCode,
        country: entity.country,
        latitude: entity.latitude,
        longitude: entity.longitude,
        phone: entity.phone,
        isActive: entity.isActive,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

