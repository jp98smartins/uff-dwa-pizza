part of 'admin_profile_cubit.dart';

abstract interface class AdminProfileState extends Equatable {
  const AdminProfileState();

  @override
  List<Object> get props => [];
}

final class AdminProfileException extends AdminProfileState {
  final AppException exception;

  const AdminProfileException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class AdminProfileLoading extends AdminProfileState {}

final class AdminProfileLoaded extends AdminProfileState {
  final AuthEntity entity;

  const AdminProfileLoaded(this.entity);

  @override
  List<Object> get props => [entity];
}

final class ClientProfileLogout extends AdminProfileState {}
