import 'dart:convert';
import 'dart:typed_data';

final class ClientProductModel {
  final int id;
  final String name;
  final String picture;
  final int value;

  const ClientProductModel({
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

  factory ClientProductModel.fromMap(Map<String, Object> map) {
    return ClientProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      picture: map['picture'] as String,
      value: map['value'] as int,
    );
  }
}


enum ClientProductDrinkTypeEnum {
  non_alcoholic,
  alcoholic;

  factory ClientProductDrinkTypeEnum.fromString(String value) {
    switch (value) {
      case 'ALCOHOLIC':
        return ClientProductDrinkTypeEnum.alcoholic;
      case 'NON_ALCOHOLIC':
        return ClientProductDrinkTypeEnum.non_alcoholic;
      default:
        throw Exception('Invalid value');
    }
  }

  String get description {
    switch (this) {
      case ClientProductDrinkTypeEnum.alcoholic:
        return 'Alcoólica';
      case ClientProductDrinkTypeEnum.non_alcoholic:
        return 'Não alcoólica';
    }
  }
}

final class ClientProductDrinkModel extends ClientProductModel {
  final int volume;
  final ClientProductDrinkTypeEnum type;

  const ClientProductDrinkModel({
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

  factory ClientProductDrinkModel.fromMap(Map map) {
    final data = Map<String, Object>.from(map);
    return ClientProductDrinkModel(
      id: data['id'] as int,
      name: data['name'] as String,
      picture: data['picture'] as String? ?? '',
      value: data['value'] as int,
      volume: data['volume'] as int,
      type: ClientProductDrinkTypeEnum.fromString(data['type'] as String),
    );
  }
}

enum ClientProductFoodSizeEnum {
  s,
  m,
  l;

  factory ClientProductFoodSizeEnum.fromString(String value) {
    switch (value) {
      case 'S':
        return ClientProductFoodSizeEnum.s;
      case 'M':
        return ClientProductFoodSizeEnum.m;
      case 'L':
        return ClientProductFoodSizeEnum.l;
      default:
        throw Exception('Invalid value');
    }
  }

  String get description {
    switch (this) {
      case ClientProductFoodSizeEnum.s:
        return 'Pequena';
      case ClientProductFoodSizeEnum.m:
        return 'Média';
      case ClientProductFoodSizeEnum.l:
        return 'Grande';
    }
  }
}

final class ClientProductFoodModel extends ClientProductModel {
  final ClientProductFoodSizeEnum size;
  final String description;

  const ClientProductFoodModel({
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

  factory ClientProductFoodModel.fromMap(Map map) {
    final data = Map<String, Object>.from(map);
    return ClientProductFoodModel(
      id: data['id'] as int,
      name: data['name'] as String,
      picture: data['picture'] as String? ?? '',
      value: data['value'] as int,
      size: ClientProductFoodSizeEnum.fromString(data['size'] as String),
      description: data['description'] as String,
    );
  }
}

final class ClientProductShowcaseModel {
  final List<ClientProductDrinkModel> drinks;
  final List<ClientProductFoodModel> foods;
  
  const ClientProductShowcaseModel({
    required this.drinks,
    required this.foods,
  });

  factory ClientProductShowcaseModel.fromMap(Map map) {
    final foods = List<Map>.from(map['pizzas'] as List) //
        .map(ClientProductFoodModel.fromMap)
        .toList();
    
    final drinks = List<Map>.from(map['drinks'] as List) //
        .map(ClientProductDrinkModel.fromMap)
        .toList();

    return ClientProductShowcaseModel(
      foods: foods,
      drinks: drinks,
    );
  }
}
