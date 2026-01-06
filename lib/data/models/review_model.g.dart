// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  id: json['id'] as String,
  userID: json['userID'] as String,
  userName: json['userName'] as String?,
  coffeeTypeID: json['coffeeTypeID'] as String?,
  coffeeTypeName: json['coffeeTypeName'] as String?,
  locationID: json['locationID'] as String?,
  locationName: json['locationName'] as String?,
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'userName': instance.userName,
      'coffeeTypeID': instance.coffeeTypeID,
      'coffeeTypeName': instance.coffeeTypeName,
      'locationID': instance.locationID,
      'locationName': instance.locationName,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
