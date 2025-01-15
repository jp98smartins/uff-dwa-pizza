final class ClientPaymentMethodModel {
  final int id;
  final String number;

  const ClientPaymentMethodModel({
    required this.id,
    required this.number,
  });

  factory ClientPaymentMethodModel.fromMap(Map<String, Object> map) {
    return ClientPaymentMethodModel(
      id: map['id'] as int,
      number: map['number'] as String,
    );
  }
}
