import '../../../../../core/core.dart';
import '../../data/admin_order_repository.dart';
import '../../domain/models/admin_order_model.dart';

part 'admin_orders_states.dart';

final class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  final AdminOrderRepository _adminOrderRepository;

  AdminOrdersCubit(
    this._adminOrderRepository,
  ) : super(AdminOrdersLoading());

  Future<void> getOrders() async {
    emit(AdminOrdersLoading());

    try {
      final orders = await _adminOrderRepository.getOrders();
      emit(AdminOrdersLoaded(orders, false));
    } on AppException catch (exception) {
      emit(AdminOrdersException(exception));
      await Future.delayed(const Duration(seconds: 1), getOrders);
    }
  }

  Future<void> updateStatus(int id, String status) async {
    emit(AdminOrdersLoading());

    try {
      await _adminOrderRepository.patchOrderStatus(id, status);
      final orders = await _adminOrderRepository.getOrders();
      emit(AdminOrdersLoaded(orders, true));
    } on AppException catch (exception) {
      emit(AdminOrdersException(exception));
      await Future.delayed(const Duration(seconds: 1), () => updateStatus(id, status));
    }
  }
}
