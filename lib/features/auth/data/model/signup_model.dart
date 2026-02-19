import 'dart:convert';

import 'package:study_hub/features/auth/domain/entities/signup_entity.dart';

class SignupModel {
  String id;
  String username;
  String email;
  String password;
  DateTime lastSeen;
  String fullname;

  SignupModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.lastSeen,
    required this.fullname,
  });

  SignupModel copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    DateTime? lastSeen,
    String? fullname,
  }) => SignupModel(
    id: id ?? this.id,
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    lastSeen: lastSeen ?? this.lastSeen,
    fullname: fullname ?? this.fullname,
  );

  factory SignupModel.fromRawJson(String str) =>
      SignupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    lastSeen: DateTime.parse(json["last_seen"]),
    fullname: json["fullname"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "password": password,
    "last_seen": lastSeen.toIso8601String(),
    "fullname": fullname,
  };

  SignupEntity toEntity() {
    return SignupEntity(
      id: id,
      username: username,
      email: email,
      password: password,
      fullname: fullname,
    );
  }
}
