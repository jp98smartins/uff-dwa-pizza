part of 'admin_user_cubit.dart';

abstract interface class AdminUserState extends Equatable {
  const AdminUserState();

  @override
  List<Object> get props => [];
}

final class AdminUserException extends AdminUserState {
  final AppException exception;

  const AdminUserException(this.exception);

  @override
  List<Object> get props => [exception];
}

final class AdminUserLoading extends AdminUserState {}

final class AdminProductLoaded extends AdminUserState {
  final AdminUserByTypeModel users;
  final bool isUserAdded;

  const AdminProductLoaded(
    this.users,
    this.isUserAdded,
  );

  @override
  List<Object> get props => [users, isUserAdded];
}
