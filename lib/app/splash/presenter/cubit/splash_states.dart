part of 'splash_cubit.dart';

abstract interface class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashException extends SplashState {
  final AppException exception;

  const SplashException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class SplashLoading extends SplashState {}

final class SplashLoaded extends SplashState {
  final AuthEntity? entity;

  const SplashLoaded(this.entity);

  @override
  List<Object> get props => [if (entity != null) entity!];
}
