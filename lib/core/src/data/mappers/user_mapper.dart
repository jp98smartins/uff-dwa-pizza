import 'dart:convert';

import '../../domain/entities/user_entity.dart';

sealed class UserMapper {
  static UserEntity fromJson(String json) => fromMap(jsonDecode(json));

  static UserEntity fromMap(Map<String, dynamic> map) {
    if (map.containsKey('address') && map.containsKey('cpf')) {
      return ClientUserEntity(
        address: map['address'] as String,
        cpf: map['cpf'] as String,
        email: map['email'] as String,
        id: map['id'] as int,
        name: map['name'] as String,
        phone: map['phone'] as String,
      );
    }

    if (map.containsKey('admission_at') && map.containsKey('pis_pasep')) {
      return EmployeeUserEntity(
        admissionDate: DateTime.parse(map['admission_at'] as String),
        email: map['email'] as String,
        id: map['id'] as int,
        name: map['name'] as String,
        phone: map['phone'] as String,
        pis: map['pis_pasep'] as String,
      );
    }

    return UserEntity(
      email: map['email'] as String,
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }

  static Map<String, dynamic> toMap(UserEntity entity) {
    final baseUser = {
      'email': entity.email,
      'id': entity.id,
      'name': entity.name,
      'phone': entity.phone,
    };

    if (entity is ClientUserEntity) {
      baseUser.addAll({
        'address': entity.address,
        'cpf': entity.cpf,
      });
    }

    if (entity is EmployeeUserEntity) {
      baseUser.addAll({
        'admission_at': entity.admissionDate.toIso8601String(),
        'pis_pasep': entity.pis,
      });
    }

    return baseUser;
  }

  static String toJson(UserEntity entity) => jsonEncode(toMap(entity));
}
