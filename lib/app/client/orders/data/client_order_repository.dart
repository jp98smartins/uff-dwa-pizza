import 'package:pizza/app/client/orders/domain/models/client_order_model.dart';

import '../../../../core/core.dart';

abstract interface class ClientOrderRepository {
  Future<List<ClientOrderModel>> getOrders();

  Future<void> postOrder(int paymentMethodId, List<int> productIds);
}

final class ClientOrderRepositoryImpl implements ClientOrderRepository {
  final HttpClient _client;

  const ClientOrderRepositoryImpl(this._client);

  @override
  Future<void> postOrder(int paymentMethodId, List<int> productIds) async {
    await _client.post(
      '/api/orders',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      body: {'payment_method': paymentMethodId, 'products': productIds},
      segment: 'Orders',
      step: 'Post Order',
    );
  }

  @override
  Future<List<ClientOrderModel>> getOrders() async {
    final response = await _client.get(
      '/api/orders',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'Orders',
      step: 'Get Orders',
    );

    if (response.data is List) {
      if ((response.data as List).isEmpty) {
        return [];
      }
    }

    return List<Map>.from(response.data as List) //
        .map(ClientOrderModel.fromMap)
        .toList();
  }
}
