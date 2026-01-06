import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final bool isAdmin;
  final DateTime? createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    required this.isAdmin,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, email, fullName, phone, isAdmin, createdAt];
}

