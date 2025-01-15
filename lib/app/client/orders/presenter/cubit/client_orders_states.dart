part of 'client_orders_cubit.dart';

abstract interface class ClientOrdersState extends Equatable {
  const ClientOrdersState();

  @override
  List<Object> get props => [];
}

final class ClientOrdersException extends ClientOrdersState {
  final AppException exception;

  const ClientOrdersException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class ClientOrdersLoading extends ClientOrdersState {}

final class ClientOrdersLoaded extends ClientOrdersState {
  final List<ClientOrderModel> orders;

  const ClientOrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}
