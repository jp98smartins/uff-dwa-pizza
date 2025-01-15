import 'dart:convert';

import '../../domain/entities/token_entity.dart';

sealed class TokenMapper {
  static TokenEntity fromJson(String json) => fromMap(jsonDecode(json));

  static TokenEntity fromMap(Map<String, dynamic> map) {
    return TokenEntity(value: map['access']);
  }

  static Map<String, dynamic> toMap(TokenEntity entity) {
    return {'access': entity.value};
  }

  static String toJson(TokenEntity entity) => jsonEncode(toMap(entity));
}
