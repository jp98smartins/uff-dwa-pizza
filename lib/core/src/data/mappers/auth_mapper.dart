import 'dart:convert';

import '../../domain/entities/auth_entity.dart';
import 'token_mapper.dart';
import 'user_mapper.dart';

sealed class AuthMapper {
  static AuthEntity fromJson(String json) => fromMap(jsonDecode(json));

  static AuthEntity fromMap(Map<String, dynamic> map) {
    return AuthEntity(
      token: TokenMapper.fromMap(map),
      user: UserMapper.fromMap(Map<String, dynamic>.from(map['user'] as Map)),
    );
  }

  static Map<String, dynamic> toMap(AuthEntity entity) {
    return {
      'user': UserMapper.toMap(entity.user),
      ...TokenMapper.toMap(entity.token),
    };
  }

  static String toJson(AuthEntity entity) => jsonEncode(toMap(entity));
}
