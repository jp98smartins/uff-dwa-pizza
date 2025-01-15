import '../../../../../core/core.dart';
import '../../../orders/data/client_order_repository.dart';
import '../../../payment_method/data/client_payment_method_repository.dart';
import '../../../payment_method/domain/models/client_payment_method_model.dart';
import '../../data/client_cart_repository.dart';
import '../../domain/models/client_cart_model.dart';

part 'client_cart_states.dart';

final class ClientCartCubit extends Cubit<ClientCartState> {
  final ClientCartRepository _clientCartRepository;
  final ClientOrderRepository _clientOrderRepository;
  final ClientPaymentMethodRepository _clientPaymentMethodRepository;

  ClientCartCubit(
    this._clientCartRepository,
    this._clientOrderRepository,
    this._clientPaymentMethodRepository,
  ) : super(ClientCartLoading());

  Future<void> clearCart() async {
    emit(ClientCartLoading());

    try {
      await _clientCartRepository.clearCart();
      final cart = _clientCartRepository.getCart();
      final paymentMethods = await _clientPaymentMethodRepository.getPaymentMethods();
      emit(ClientCartLoaded(cart, paymentMethods));
    } on AppException catch (exception) {
      emit(ClientCartException(exception));
      await Future.delayed(const Duration(seconds: 1), clearCart);
    }
  }

  Future<void> deleteProductFromCart(int id) async {
    emit(ClientCartLoading());

    try {
      await _clientCartRepository.deleteProductFromCart(id);
      final cart = _clientCartRepository.getCart();
      final paymentMethods = await _clientPaymentMethodRepository.getPaymentMethods();
      emit(ClientCartLoaded(cart, paymentMethods));
    } on AppException catch (exception) {
      emit(ClientCartException(exception));
      await Future.delayed(const Duration(seconds: 1), () => deleteProductFromCart(id));
    }
  }

  Future<void> getCart() async {
    emit(ClientCartLoading());

    try {
      final cart = _clientCartRepository.getCart();
      final paymentMethods = await _clientPaymentMethodRepository.getPaymentMethods();
      emit(ClientCartLoaded(cart, paymentMethods));
    } on AppException catch (exception) {
      emit(ClientCartException(exception));
      await Future.delayed(const Duration(seconds: 1), getCart);
    }
  }

  Future<void> createOrder(
    int paymentMethodId,
    List<int> productIds,
  ) async {
    emit(ClientCartLoading());

    try {
      await _clientOrderRepository.postOrder(paymentMethodId, productIds);
      await _clientCartRepository.clearCart();
      emit(ClientCartSuccess());
    } on AppException catch (exception) {
      emit(ClientCartException(exception));
      await Future.delayed(
        const Duration(seconds: 1),
        () => createOrder(paymentMethodId, productIds),
      );
    }
  }
}
