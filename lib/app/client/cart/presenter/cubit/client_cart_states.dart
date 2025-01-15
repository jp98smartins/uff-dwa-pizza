part of 'client_cart_cubit.dart';

abstract interface class ClientCartState extends Equatable {
  const ClientCartState();

  @override
  List<Object> get props => [];
}

final class ClientCartException extends ClientCartState {
  final AppException exception;

  const ClientCartException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class ClientCartLoading extends ClientCartState {}

final class ClientCartLoaded extends ClientCartState {
  final ClientCartModel cart;
  final List<ClientPaymentMethodModel> paymentMethods;

  const ClientCartLoaded(this.cart, this.paymentMethods);

  List<int> get productIds => cart.products.map((product) => product.id).toList();

  @override
  List<Object> get props => [cart];
}

final class ClientCartSuccess extends ClientCartState {}
