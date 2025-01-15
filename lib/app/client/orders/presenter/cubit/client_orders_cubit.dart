import 'package:pizza/app/client/orders/domain/models/client_order_model.dart';

import '../../../../../core/core.dart';
import '../../data/client_order_repository.dart';

part 'client_orders_states.dart';

final class ClientOrdersCubit extends Cubit<ClientOrdersState> {
  final ClientOrderRepository _clientOrderRepository;

  ClientOrdersCubit(
    this._clientOrderRepository,
  ) : super(ClientOrdersLoading());

  Future<void> getOrders() async {
    emit(ClientOrdersLoading());

    try {
      final orders = await _clientOrderRepository.getOrders();
      emit(ClientOrdersLoaded(orders));
    } on AppException catch (exception) {
      emit(ClientOrdersException(exception));
      await Future.delayed(const Duration(seconds: 1), getOrders);
    }
  }
}
