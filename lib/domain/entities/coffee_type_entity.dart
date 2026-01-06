import 'package:equatable/equatable.dart';

class CoffeeTypeEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String? imageURL;
  final bool isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CoffeeTypeEntity({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.imageURL,
    required this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageURL,
        isAvailable,
        createdAt,
        updatedAt,
      ];
}

