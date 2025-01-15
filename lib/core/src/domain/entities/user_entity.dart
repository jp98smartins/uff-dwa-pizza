import '../../exports/exports.dart';

base class UserEntity extends Equatable {
  final String email;
  final int id;
  final String name;
  final String phone;

  const UserEntity({
    required this.email,
    required this.id,
    required this.name,
    required this.phone,
  });

  bool get isClient => this is ClientUserEntity;

  bool get isEmployee => this is EmployeeUserEntity;

  ClientUserEntity get asClient => this as ClientUserEntity;

  EmployeeUserEntity get asEmployee => this as EmployeeUserEntity;

  @override
  List<Object?> get props => [email, id, name, phone];
}

final class ClientUserEntity extends UserEntity {
  final String address;
  final String cpf;

  const ClientUserEntity({
    required this.address,
    required this.cpf,
    required super.email,
    required super.id,
    required super.name,
    required super.phone,
  });

  @override
  List<Object?> get props => [address, cpf, email, id, name, phone];
}

final class EmployeeUserEntity extends UserEntity {
  final DateTime admissionDate;
  final String pis;

  const EmployeeUserEntity({
    required this.admissionDate,
    required super.email,
    required super.id,
    required super.name,
    required super.phone,
    required this.pis,
  });

  @override
  List<Object?> get props => [admissionDate, email, id, name, phone, pis];
}
