import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String fullname;
  final String? avatarPath;
  final DateTime? lastSeen;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullname,
    this.avatarPath,
    this.lastSeen,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        fullname,
        avatarPath,
        lastSeen,
      ];
}