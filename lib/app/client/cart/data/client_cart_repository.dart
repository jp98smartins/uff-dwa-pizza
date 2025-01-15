import '../../../../core/core.dart';
import '../../products/domain/models/client_product_model.dart';
import '../domain/models/client_cart_model.dart';

abstract interface class ClientCartRepository {
  Future<void> addProductToCart(ClientProductModel product);

  Future<void> clearCart();

  Future<void> deleteProductFromCart(int id);

  ClientCartModel getCart();
}

final class ClientCartRepositoryImpl implements ClientCartRepository {
  static const _cartStorageKey = 'd1c0b951-d17f-41ce-934a-7e2ff733a6e6';

  final Storage _storage;

  const ClientCartRepositoryImpl(this._storage);
  @override
  Future<void> addProductToCart(ClientProductModel product) {
    final jsonCart = _storage.read(_cartStorageKey);
    final cart = jsonCart != null ? ClientCartModel.fromJson(jsonCart) : ClientCartModel(products: []);
    cart.products.add(product);
    return _storage.save(_cartStorageKey, cart.toJson());
  }

  @override
  Future<void> clearCart() {
    return _storage.save(
      _cartStorageKey,
      ClientCartModel(products: []).toJson(),
    );
  }

  @override
  Future<void> deleteProductFromCart(int id) {
    final jsonCart = _storage.read(_cartStorageKey);
    final cart = jsonCart != null ? ClientCartModel.fromJson(jsonCart) : ClientCartModel(products: []);
    cart.products.removeWhere((p) => p.id == id);
    return _storage.save(_cartStorageKey, cart.toJson());
  }

  @override
  ClientCartModel getCart() {
    final jsonCart = _storage.read(_cartStorageKey);

    return jsonCart != null ? ClientCartModel.fromJson(jsonCart) : ClientCartModel(products: []);
  }
}
