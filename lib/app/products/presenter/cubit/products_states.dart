part of 'products_cubit.dart';

abstract interface class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsException extends ProductsState {
  final AppException exception;

  const ProductsException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final AuthEntity entity;

  const ProductsLoaded(this.entity);

  @override
  List<Object> get props => [entity];
}

final class ProductsLogout extends ProductsState {}
