final class AdminOrderItemModel {
  final int id;
  final String name;
  final int value;

  const AdminOrderItemModel({
    required this.id,
    required this.name,
    required this.value,
  });

  bool get isFood => this is AdminOrderItemFoodModel;

  bool get isDrink => this is AdminOrderItemDrinkModel;

  AdminOrderItemFoodModel get asFood => this as AdminOrderItemFoodModel;

  AdminOrderItemDrinkModel get asDrink => this as AdminOrderItemDrinkModel;

  factory AdminOrderItemModel.fromMap(Map<String, Object> map) {
    return AdminOrderItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as int,
    );
  }
}

final class AdminOrderItemDrinkModel extends AdminOrderItemModel {
  final int volume;

  const AdminOrderItemDrinkModel({
    required super.id,
    required super.name,
    required super.value,
    required this.volume,
  });

  factory AdminOrderItemDrinkModel.fromMap(Map<String, Object> map) {
    return AdminOrderItemDrinkModel(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as int,
      volume: map['volume'] as int,
    );
  }
}

enum AdminOrderItemFoodSizeEnum {
  small,
  medium,
  large;

  factory AdminOrderItemFoodSizeEnum.fromString(String value) {
    switch (value) {
      case 'SMALL':
        return AdminOrderItemFoodSizeEnum.small;
      case 'MEDIUM':
        return AdminOrderItemFoodSizeEnum.medium;
      case 'LARGE':
        return AdminOrderItemFoodSizeEnum.large;
      default:
        throw Exception('Invalid value');
    }
  }

  String get description {
    switch (this) {
      case AdminOrderItemFoodSizeEnum.small:
        return 'Pequena';
      case AdminOrderItemFoodSizeEnum.medium:
        return 'Média';
      case AdminOrderItemFoodSizeEnum.large:
        return 'Grande';
    }
  }
}

final class AdminOrderItemFoodModel extends AdminOrderItemModel {
  final AdminOrderItemFoodSizeEnum size;

  const AdminOrderItemFoodModel({
    required super.id,
    required super.name,
    required super.value,
    required this.size,
  });

  factory AdminOrderItemFoodModel.fromMap(Map<String, Object> map) {
    return AdminOrderItemFoodModel(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as int,
      size: AdminOrderItemFoodSizeEnum.fromString(map['size'] as String),
    );
  }
}

enum AdminOrderStatusEnum {
  pending,
  preparing,
  sent,
  delivered;

  bool get hasNext => this != AdminOrderStatusEnum.delivered;

  AdminOrderStatusEnum next() {
    switch (this) {
      case AdminOrderStatusEnum.pending:
        return AdminOrderStatusEnum.preparing;
      case AdminOrderStatusEnum.preparing:
        return AdminOrderStatusEnum.sent;
      case AdminOrderStatusEnum.sent:
        return AdminOrderStatusEnum.delivered;
      case AdminOrderStatusEnum.delivered:
        return AdminOrderStatusEnum.delivered;
    }
  }

  String get nextDescription {
    switch (this) {
      case AdminOrderStatusEnum.pending:
        return 'Aceitar';
      case AdminOrderStatusEnum.preparing:
        return 'Enviar';
      case AdminOrderStatusEnum.sent:
        return 'Entregar';
      case AdminOrderStatusEnum.delivered:
        return 'Entregar';
    }
  }

  factory AdminOrderStatusEnum.fromString(String value) {
    switch (value) {
      case 'PENDING':
        return AdminOrderStatusEnum.pending;
      case 'PREPARING':
        return AdminOrderStatusEnum.preparing;
      case 'SENT':
        return AdminOrderStatusEnum.sent;
      case 'DELIVERED':
        return AdminOrderStatusEnum.delivered;
      default:
        throw Exception('Invalid value');
    }
  }

  String get description {
    switch (this) {
      case AdminOrderStatusEnum.pending:
        return 'Pendente';
      case AdminOrderStatusEnum.preparing:
        return 'Preparando';
      case AdminOrderStatusEnum.sent:
        return 'Enviado';
      case AdminOrderStatusEnum.delivered:
        return 'Entregue';
    }
  }
}

final class AdminOrderModel {
  final int id;
  final String client;
  final AdminOrderStatusEnum status;
  final DateTime orderedAt;
  final int total;
  final List<AdminOrderItemModel> items;

  const AdminOrderModel({
    required this.id,
    required this.client,
    required this.status,
    required this.orderedAt,
    required this.total,
    required this.items,
  });

  factory AdminOrderModel.fromMap(Map<String, Object> map) {
    AdminOrderItemModel itemFromMap(Map<String, Object> item) {
      if (item.containsKey('volume')) {
        return AdminOrderItemDrinkModel.fromMap(item);
      } else if (item.containsKey('size')) {
        return AdminOrderItemFoodModel.fromMap(item);
      } else {
        return AdminOrderItemModel.fromMap(item);
      }
    }

    return AdminOrderModel(
      id: map['id'] as int,
      client: map['client'] as String,
      status: AdminOrderStatusEnum.fromString(map['status'] as String),
      orderedAt: DateTime.parse(map['ordered_at'] as String),
      total: map['total'] as int,
      items: List<Map<String, Object>>.from(map['products'] as List) //
          .map(itemFromMap)
          .toList(),
    );
  }
}
