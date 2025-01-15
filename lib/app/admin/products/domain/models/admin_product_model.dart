import 'dart:convert';
import 'dart:typed_data';

final class AdminProductModel {
  final int id;
  final String name;
  final String picture;
  final int value;

  const AdminProductModel({
    required this.id,
    required this.name,
    required this.picture,
    required this.value,
  });

  Uint8List get pictureBytes => base64Decode(picture);

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'picture': picture,
      'value': value,
    };
  }

  factory AdminProductModel.fromMap(Map<String, Object> map) {
    return AdminProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      picture: map['picture'] as String,
      value: map['value'] as int,
    );
  }
}

enum AdminProductDrinkTypeEnum {
  non_alcoholic,
  alcoholic;

  factory AdminProductDrinkTypeEnum.fromString(String value) {
    switch (value) {
      case 'ALCOHOLIC':
        return AdminProductDrinkTypeEnum.alcoholic;
      case 'NON_ALCOHOLIC':
        return AdminProductDrinkTypeEnum.non_alcoholic;
      default:
        throw Exception('Invalid value');
    }
  }

  String get description {
    switch (this) {
      case AdminProductDrinkTypeEnum.alcoholic:
        return 'Alcoólica';
      case AdminProductDrinkTypeEnum.non_alcoholic:
        return 'Não alcoólica';
    }
  }
}

final class AdminProductDrinkModel extends AdminProductModel {
  final int volume;
  final AdminProductDrinkTypeEnum type;

  const AdminProductDrinkModel({
    required super.id,
    required super.name,
    required super.picture,
    required super.value,
    required this.volume,
    required this.type,
  });

  @override
  Map<String, Object> toMap() {
    return {
      ...super.toMap(),
      'volume': volume,
      'type': type.name.toUpperCase(),
    };
  }

  factory AdminProductDrinkModel.fromMap(Map<String, Object> map) {
    return AdminProductDrinkModel(
      id: map['id'] as int,
      name: map['name'] as String,
      picture: map['picture'] as String,
      value: map['value'] as int,
      volume: map['volume'] as int,
      type: AdminProductDrinkTypeEnum.fromString(map['type'] as String),
    );
  }

  factory AdminProductDrinkModel.fromMapAndId(int id, Map<String, Object> map) {
    return AdminProductDrinkModel(
      id: id,
      name: map['name'] as String,
      picture: map['picture'] as String,
      value: map['value'] as int,
      volume: map['volume'] as int,
      type: AdminProductDrinkTypeEnum.fromString(map['type'] as String),
    );
  }
}

enum AdminProductFoodSizeEnum {
  s,
  m,
  l;

  factory AdminProductFoodSizeEnum.fromString(String value) {
    switch (value) {
      case 'S':
        return AdminProductFoodSizeEnum.s;
      case 'M':
        return AdminProductFoodSizeEnum.m;
      case 'L':
        return AdminProductFoodSizeEnum.l;
      default:
        throw Exception('Invalid value');
    }
  }

  String get description {
    switch (this) {
      case AdminProductFoodSizeEnum.s:
        return 'Pequena';
      case AdminProductFoodSizeEnum.m:
        return 'Média';
      case AdminProductFoodSizeEnum.l:
        return 'Grande';
    }
  }
}

final class AdminProductFoodModel extends AdminProductModel {
  final AdminProductFoodSizeEnum size;
  final String description;

  const AdminProductFoodModel({
    required super.id,
    required super.name,
    required super.picture,
    required super.value,
    required this.size,
    required this.description,
  });

  @override
  Map<String, Object> toMap() {
    return {
      ...super.toMap(),
      'size': size.name.toUpperCase(),
      'description': description,
    };
  }

  factory AdminProductFoodModel.fromMap(Map<String, Object> map) {
    return AdminProductFoodModel(
      id: map['id'] as int,
      name: map['name'] as String,
      picture: map['picture'] as String,
      value: map['value'] as int,
      size: AdminProductFoodSizeEnum.fromString(map['size'] as String),
      description: map['description'] as String,
    );
  }

  factory AdminProductFoodModel.fromMapAndId(int id, Map<String, Object> map) {
    return AdminProductFoodModel(
      id: id,
      name: map['name'] as String,
      picture: map['picture'] as String,
      value: map['value'] as int,
      size: AdminProductFoodSizeEnum.fromString(map['size'] as String),
      description: map['description'] as String,
    );
  }
}

final class AdminProductShowcaseModel {
  final List<AdminProductDrinkModel> drinks;
  final List<AdminProductFoodModel> foods;

  const AdminProductShowcaseModel({
    required this.drinks,
    required this.foods,
  });

  factory AdminProductShowcaseModel.fromMap(Map<String, dynamic> map) {
    final foods = List<Map<String, Object>>.from(map['pizzas'] as List) //
        .map(AdminProductFoodModel.fromMap)
        .toList();

    final drinks = List<Map<String, Object>>.from(map['drinks'] as List) //
        .map(AdminProductDrinkModel.fromMap)
        .toList();

    return AdminProductShowcaseModel(
      foods: foods,
      drinks: drinks,
    );
  }
}
