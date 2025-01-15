final class AdminUserModel {
  final int id;
  final String name;
  final String phone;
  final String email;

  const AdminUserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  factory AdminUserModel.fromMap(Map<String, Object> map) {
    return AdminUserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
    );
  }
}

final class AdminUserAdminModel extends AdminUserModel {
  final String pis;
  final DateTime admissionAt;

  const AdminUserAdminModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required this.pis,
    required this.admissionAt,
  });

  @override
  Map<String, Object> toMap() {
    return {
      ...super.toMap(),
      'pis': pis,
      'admission_at': admissionAt.toIso8601String(),
    };
  }

  factory AdminUserAdminModel.fromMap(Map<String, Object> map) {
    return AdminUserAdminModel(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      pis: map['pis'] as String,
      admissionAt: DateTime.parse(map['admission_at'] as String),
    );
  }
}

final class AdminUserClientModel extends AdminUserModel {
  final String cpf;
  final String address;

  const AdminUserClientModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required this.cpf,
    required this.address,
  });

  @override
  Map<String, Object> toMap() {
    return {
      ...super.toMap(),
      'cpf': cpf,
      'address': address,
    };
  }

  factory AdminUserClientModel.fromMap(Map<String, Object> map) {
    return AdminUserClientModel(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      cpf: map['cpf'] as String,
      address: map['address'] as String,
    );
  }
}

final class AdminUserByTypeModel {
  final List<AdminUserAdminModel> admins;
  final List<AdminUserClientModel> clients;

  const AdminUserByTypeModel({
    required this.admins,
    required this.clients,
  });

  factory AdminUserByTypeModel.fromMap(Map<String, dynamic> map) {
    final admins = List<Map<String, Object>>.from(map['admins'] as List) //
        .map(AdminUserAdminModel.fromMap)
        .toList();

    final clients = List<Map<String, Object>>.from(map['clients'] as List) //
        .map(AdminUserClientModel.fromMap)
        .toList();

    return AdminUserByTypeModel(
      admins: admins,
      clients: clients,
    );
  }
}
