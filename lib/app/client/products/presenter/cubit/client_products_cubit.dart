import 'package:pizza/app/client/cart/data/client_cart_repository.dart';

import '../../../../../core/core.dart';
import '../../data/client_product_repository.dart';
import '../../domain/models/client_product_model.dart';

part 'client_products_states.dart';

final class ClientProductsCubit extends Cubit<ClientProductsState> {
  final ClientCartRepository _clientCartRepository;
  final ClientProductRepository _clientProductRepository;

  ClientProductsCubit(
    this._clientCartRepository,
    this._clientProductRepository,
  ) : super(ClientProductsLoading());

  Future<void> getProductsShowcase() async {
    emit(ClientProductsLoading());

    try {
      final products = await _clientProductRepository.getProductsShowcase();
      emit(ClientProductsLoaded(products, false));
    } on AppException catch (exception) {
      emit(ClientProductsException(exception));
      await Future.delayed(const Duration(seconds: 1), getProductsShowcase);
    }
  }

  Future<void> addToCart(ClientProductModel product) async {
    emit(ClientProductsLoading());

    try {
      await _clientCartRepository.addProductToCart(product);
      final products = await _clientProductRepository.getProductsShowcase();
      emit(ClientProductsLoaded(products, true));
    } on AppException catch (exception) {
      emit(ClientProductsException(exception));
      await Future.delayed(const Duration(seconds: 1), getProductsShowcase);
    }
  }
}
