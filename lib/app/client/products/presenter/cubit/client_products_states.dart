part of 'client_products_cubit.dart';

abstract interface class ClientProductsState extends Equatable {
  const ClientProductsState();

  @override
  List<Object> get props => [];
}

final class ClientProductsException extends ClientProductsState {
  final AppException exception;

  const ClientProductsException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class ClientProductsLoading extends ClientProductsState {}

final class ClientProductsLoaded extends ClientProductsState {
  final ClientProductShowcaseModel products;
  final bool productAddedToCart;

  const ClientProductsLoaded(this.products, this.productAddedToCart);

  @override
  List<Object> get props => [products, productAddedToCart];
}
