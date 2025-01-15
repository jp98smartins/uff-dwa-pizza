part of 'admin_orders_cubit.dart';

abstract interface class AdminOrdersState extends Equatable {
  const AdminOrdersState();

  @override
  List<Object> get props => [];
}

final class AdminOrdersException extends AdminOrdersState {
  final AppException exception;

  const AdminOrdersException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class AdminOrdersLoading extends AdminOrdersState {}

final class AdminOrdersLoaded extends AdminOrdersState {
  final List<AdminOrderModel> orders;
  final bool isStatusUpdated;

  const AdminOrdersLoaded(this.orders, this.isStatusUpdated);

  @override
  List<Object> get props => [orders, isStatusUpdated];
}
