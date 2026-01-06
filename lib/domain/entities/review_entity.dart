import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String userID;
  final String? userName;
  final String? coffeeTypeID;
  final String? coffeeTypeName;
  final String? locationID;
  final String? locationName;
  final int rating;
  final String? comment;
  final DateTime? createdAt;

  const ReviewEntity({
    required this.id,
    required this.userID,
    this.userName,
    this.coffeeTypeID,
    this.coffeeTypeName,
    this.locationID,
    this.locationName,
    required this.rating,
    this.comment,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userID,
        userName,
        coffeeTypeID,
        coffeeTypeName,
        locationID,
        locationName,
        rating,
        comment,
        createdAt,
      ];
}

