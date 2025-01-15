import '../../../../core/core.dart';
import '../domain/models/admin_product_model.dart';

abstract interface class AdminProductRepository {
  Future<void> deleteProduct(int id);

  Future<AdminProductShowcaseModel> getProducts();

  Future<void> patchProduct(AdminProductModel product);

  Future<void> postProduct(AdminProductModel product);
}

final class AdminProductRepositoryImpl implements AdminProductRepository {
  final HttpClient _client;

  const AdminProductRepositoryImpl(this._client);

  @override
  Future<void> deleteProduct(int id) async {
    await _client.delete(
      '/api/products/$id',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'Product',
      step: 'Delete Product',
    );
  }

  @override
  Future<AdminProductShowcaseModel> getProducts() async {
    final response = await _client.get(
      '/api/products',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'Products',
      step: 'Get Products',
    );

    return AdminProductShowcaseModel.fromMap(response.dataAsMap);
  }

  @override
  Future<void> patchProduct(AdminProductModel product) async {
    await _client.patch(
      '/api/products/${product.id}',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      body: product.toMap(),
      segment: 'Product',
      step: 'Patch Product',
    );
  }

  @override
  Future<void> postProduct(AdminProductModel product) async {
    if (product is AdminProductDrinkModel) {
      await _client.post(
        '/api/products/drinks',
        authenticate: true,
        headers: {
          'ngrok-skip-browser-warning': '69420',
        },
        body: product.toMap(),
        segment: 'Product',
        step: 'Post Product (Drink)',
      );

      return;
    }

    if (product is AdminProductFoodModel) {
      await _client.post(
        '/api/products/pizzas',
        authenticate: true,
        headers: {
          'ngrok-skip-browser-warning': '69420',
        },
        body: product.toMap(),
        segment: 'Product',
        step: 'Post Product (Pizza)',
      );

      return;
    }
  }
}
