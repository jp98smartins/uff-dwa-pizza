part of 'client_payment_method_cubit.dart';

abstract interface class ClientPaymentMethodState extends Equatable {
  const ClientPaymentMethodState();

  @override
  List<Object> get props => [];
}

final class ClientPaymentMethodException extends ClientPaymentMethodState {
  final AppException exception;

  const ClientPaymentMethodException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class ClientPaymentMethodLoading extends ClientPaymentMethodState {}

final class ClientPaymentMethodLoaded extends ClientPaymentMethodState {
  final List<ClientPaymentMethodModel> paymentMethods;

  const ClientPaymentMethodLoaded(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}
