part of 'auth_cubit.dart';

abstract interface class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthException extends AuthState {
  final AppException exception;

  const AuthException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignInSuccess extends AuthState {}

final class AuthSignUpSuccess extends AuthState {}
