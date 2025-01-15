import '../../../../core/core.dart';
import '../domain/models/client_payment_method_model.dart';

abstract interface class ClientPaymentMethodRepository {
  Future<void> deletePaymentMethod(int id);

  Future<List<ClientPaymentMethodModel>> getPaymentMethods();

  Future<void> postPaymentMethod(String number);
}

final class ClientPaymentMethodRepositoryImpl implements ClientPaymentMethodRepository {
  final HttpClient _client;

  const ClientPaymentMethodRepositoryImpl(this._client);

  @override
  Future<void> deletePaymentMethod(int id) async {
    await _client.delete(
      '/api/payment_methods/$id',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'Payment Method',
      step: 'Delete Payment Method',
    );
  }

  @override
  Future<List<ClientPaymentMethodModel>> getPaymentMethods() async {
    final response = await _client.get(
      '/api/payment_methods',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      segment: 'Payment Method',
      step: 'Get Payment Methods',
    );

    if (response.data is List) {
      if ((response.data as List).isEmpty) {
        return [];
      }
    }

    return List<Map<String, Object>>.from(response.dataAsMap['payment_methods'] as List) //
        .map(ClientPaymentMethodModel.fromMap)
        .toList();
  }

  @override
  Future<void> postPaymentMethod(String number) async {
    await _client.post(
      '/api/payment_methods',
      authenticate: true,
      headers: {
        'ngrok-skip-browser-warning': '69420',
      },
      body: {'number': number},
      segment: 'Payment Method',
      step: 'Post Payment Method',
    );
  }
}
