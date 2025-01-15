part of 'admin_product_cubit.dart';

abstract interface class AdminProductState extends Equatable {
  const AdminProductState();

  @override
  List<Object> get props => [];
}

final class AdminProductException extends AdminProductState {
  final AppException exception;

  const AdminProductException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class AdminProductLoading extends AdminProductState {}

final class AdminProductLoaded extends AdminProductState {
  final AdminProductShowcaseModel products;
  final bool isProductAdded;
  final bool isProductUpdated;

  const AdminProductLoaded(
    this.products,
    this.isProductAdded,
    this.isProductUpdated,
  );

  @override
  List<Object> get props => [products, isProductAdded, isProductUpdated];
}
