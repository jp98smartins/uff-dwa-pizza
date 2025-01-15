import '../../../../core/core.dart';
import '../domain/models/client_product_model.dart';

abstract interface class ClientProductRepository {
  Future<ClientProductShowcaseModel> getProductsShowcase();
}

final class ClientProductRepositoryImpl implements ClientProductRepository {
  final HttpClient _client;

  const ClientProductRepositoryImpl(this._client);

  @override
  Future<ClientProductShowcaseModel> getProductsShowcase() async {
    final response = await _client.get(
      '/api/products',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'Products',
      step: 'Get Products',
    );

    return ClientProductShowcaseModel.fromMap(response.dataAsMap);
  }
}
