final class ClientOrderItemModel {
  final int id;
  final String name;
  final int value;

  const ClientOrderItemModel({
    required this.id,
    required this.name,
    required this.value,
  });

  factory ClientOrderItemModel.fromMap(Map<String, Object> map) {
    return ClientOrderItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as int,
    );
  }
}

final class ClientOrderItemDrinkModel extends ClientOrderItemModel {
  final int volume;

  const ClientOrderItemDrinkModel({
    required super.id,
    required super.name,
    required super.value,
    required this.volume,
  });

  factory ClientOrderItemDrinkModel.fromMap(Map<String, Object> map) {
    return ClientOrderItemDrinkModel(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as int,
      volume: map['volume'] as int,
    );
  }
}

final class ClientOrderItemFoodModel extends ClientOrderItemModel {
  final String size;

  const ClientOrderItemFoodModel({
    required super.id,
    required super.name,
    required super.value,
    required this.size,
  });

  factory ClientOrderItemFoodModel.fromMap(Map<String, Object> map) {
    return ClientOrderItemFoodModel(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as int,
      size: map['size'] as String,
    );
  }
}

enum ClientOrderStatusEnum {
  pending,
  preparing,
  sent,
  delivered;

  factory ClientOrderStatusEnum.fromString(String value) {
    switch (value) {
      case 'PENDING':
        return ClientOrderStatusEnum.pending;
      case 'PREPARING':
        return ClientOrderStatusEnum.preparing;
      case 'SENT':
        return ClientOrderStatusEnum.sent;
      case 'DELIVERED':
        return ClientOrderStatusEnum.delivered;
      default:
        throw Exception('Invalid value');
    }
  }

  String get description {
    switch (this) {
      case ClientOrderStatusEnum.pending:
        return 'Pendente';
      case ClientOrderStatusEnum.preparing:
        return 'Preparando';
      case ClientOrderStatusEnum.sent:
        return 'Enviado';
      case ClientOrderStatusEnum.delivered:
        return 'Entregue';
    }
  }
}

final class ClientOrderModel {
  final int id;
  final String client;
  final ClientOrderStatusEnum status;
  final DateTime orderedAt;
  final int total;
  final List<ClientOrderItemModel> items;

  const ClientOrderModel({
    required this.id,
    required this.client,
    required this.status,
    required this.orderedAt,
    required this.total,
    required this.items,
  });

  factory ClientOrderModel.fromMap(Map map) {
    final data = Map<String, Object>.from(map);

    ClientOrderItemModel itemFromMap(Map item) {
      final data = Map<String, Object>.from(item);

      if (data.containsKey('volume')) {
        return ClientOrderItemDrinkModel.fromMap(data);
      } else if (data.containsKey('size')) {
        return ClientOrderItemFoodModel.fromMap(data);
      } else {
        return ClientOrderItemModel.fromMap(data);
      }
    }

    return ClientOrderModel(
      id: data['id'] as int,
      client: data['client'] as String,
      status: ClientOrderStatusEnum.fromString(data['status'] as String),
      orderedAt: DateTime.parse(data['ordered_at'] as String),
      total: data['total'] as int,
      items: List<Map>.from(data['products'] as List) //
          .map(itemFromMap)
          .toList(),
    );
  }
}
