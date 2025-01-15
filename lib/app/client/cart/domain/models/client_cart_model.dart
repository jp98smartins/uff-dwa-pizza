import 'dart:convert';

import '../../../products/domain/models/client_product_model.dart';

final class ClientCartModel {
  final List<ClientProductModel> products;

  const ClientCartModel({
    required this.products,
  });

  String toJson() => jsonEncode(toMap());

  Map<String, Object> toMap() => {
        'products': products.map((p) => p.toMap()).toList(),
      };

  factory ClientCartModel.fromJson(String source) {
    final map = Map<String, Object>.from(jsonDecode(source) as Map);
    return ClientCartModel.fromMap(map);
  }

  factory ClientCartModel.fromMap(Map<String, Object> map) {
    ClientProductModel productFromMap(Map map) {
      final typpedMap = Map<String, Object>.from(map);

      if (typpedMap.containsKey('size')) {
        return ClientProductFoodModel.fromMap(typpedMap);
      } else {
        return ClientProductDrinkModel.fromMap(typpedMap);
      }
    }

    return ClientCartModel(
      products: List<Map>.from(map['products'] as List) //
          .map(productFromMap)
          .toList(),
    );
  }
}
