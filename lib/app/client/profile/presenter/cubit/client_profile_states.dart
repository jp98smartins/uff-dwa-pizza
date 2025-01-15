part of 'client_profile_cubit.dart';

abstract interface class ClientProfileState extends Equatable {
  const ClientProfileState();

  @override
  List<Object> get props => [];
}

final class ClientProfileException extends ClientProfileState {
  final AppException exception;

  const ClientProfileException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class ClientProfileLoading extends ClientProfileState {}

final class ClientProfileLoaded extends ClientProfileState {
  final AuthEntity entity;

  const ClientProfileLoaded(this.entity);

  @override
  List<Object> get props => [entity];
}

final class ClientProfileLogout extends ClientProfileState {}
