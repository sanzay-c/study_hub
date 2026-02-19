import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  final int? id; 
  final String accessToken;
  final String refreshToken;
  final DateTime? createdAt; 

  const AuthToken({
    this.id, 
    required this.accessToken,
    required this.refreshToken,
    this.createdAt, 
  });

  @override
  List<Object?> get props => [id, accessToken, refreshToken, createdAt];
}
