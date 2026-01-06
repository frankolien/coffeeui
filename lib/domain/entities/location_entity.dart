import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final String city;
  final String? state;
  final String? zipCode;
  final String country;
  final double? latitude;
  final double? longitude;
  final String? phone;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const LocationEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    this.state,
    this.zipCode,
    required this.country,
    this.latitude,
    this.longitude,
    this.phone,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        city,
        state,
        zipCode,
        country,
        latitude,
        longitude,
        phone,
        isActive,
        createdAt,
        updatedAt,
      ];
}

