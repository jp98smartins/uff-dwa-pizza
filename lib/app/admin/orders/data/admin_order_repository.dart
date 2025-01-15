import '../../../../core/core.dart';
import '../domain/models/admin_order_model.dart';

abstract interface class AdminOrderRepository {
  Future<List<AdminOrderModel>> getOrders();

  Future<void> patchOrderStatus(int id, String status);
}

final class AdminOrderRepositoryImpl implements AdminOrderRepository {
  final HttpClient _client;

  const AdminOrderRepositoryImpl(this._client);

  @override
  Future<void> patchOrderStatus(int id, String status) async {
    await _client.post(
      '/api/orders/$id',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      body: {'status': status},
      segment: 'Orders',
      step: 'Patch Order Status',
    );
  }

  @override
  Future<List<AdminOrderModel>> getOrders() async {
    final response = await _client.get(
      '/api/orders',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'Orders',
      step: 'Get Orders',
    );

    return List<Map<String, Object>>.from(response.dataAsMap['orders'] as List) //
        .map(AdminOrderModel.fromMap)
        .toList();
  }
}
