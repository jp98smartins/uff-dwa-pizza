import '../../../../../core/core.dart';
import '../../data/client_payment_method_repository.dart';
import '../../domain/models/client_payment_method_model.dart';

part 'client_payment_method_states.dart';

final class ClientPaymentMethodCubit extends Cubit<ClientPaymentMethodState> {
  final ClientPaymentMethodRepository _clientPaymentMethodRepository;

  ClientPaymentMethodCubit(
    this._clientPaymentMethodRepository,
  ) : super(ClientPaymentMethodLoading());

  Future<void> createPaymentMethod(String number) async {
    emit(ClientPaymentMethodLoading());

    try {
      await _clientPaymentMethodRepository.postPaymentMethod(number);
      final paymentMethods = await _clientPaymentMethodRepository.getPaymentMethods();
      emit(ClientPaymentMethodLoaded(paymentMethods));
    } on AppException catch (exception) {
      emit(ClientPaymentMethodException(exception));
      await Future.delayed(const Duration(seconds: 1), () => createPaymentMethod(number));
    }
  }

  Future<void> deletePaymentMethod(int id) async {
    emit(ClientPaymentMethodLoading());

    try {
      await _clientPaymentMethodRepository.deletePaymentMethod(id);
      final paymentMethods = await _clientPaymentMethodRepository.getPaymentMethods();
      emit(ClientPaymentMethodLoaded(paymentMethods));
    } on AppException catch (exception) {
      emit(ClientPaymentMethodException(exception));
      await Future.delayed(const Duration(seconds: 1), () => deletePaymentMethod(id));
    }
  }

  Future<void> getPaymentMethods() async {
    emit(ClientPaymentMethodLoading());

    try {
      final paymentMethods = await _clientPaymentMethodRepository.getPaymentMethods();
      emit(ClientPaymentMethodLoaded(paymentMethods));
    } on AppException catch (exception) {
      emit(ClientPaymentMethodException(exception));
      await Future.delayed(const Duration(seconds: 1), getPaymentMethods);
    }
  }
}
