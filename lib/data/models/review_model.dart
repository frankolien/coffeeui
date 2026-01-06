import '../../domain/entities/review_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.userID,
    super.userName,
    super.coffeeTypeID,
    super.coffeeTypeName,
    super.locationID,
    super.locationName,
    required super.rating,
    super.comment,
    super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  factory ReviewModel.fromEntity(ReviewEntity entity) => ReviewModel(
        id: entity.id,
        userID: entity.userID,
        userName: entity.userName,
        coffeeTypeID: entity.coffeeTypeID,
        coffeeTypeName: entity.coffeeTypeName,
        locationID: entity.locationID,
        locationName: entity.locationName,
        rating: entity.rating,
        comment: entity.comment,
        createdAt: entity.createdAt,
      );
}

