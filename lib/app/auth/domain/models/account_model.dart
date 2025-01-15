final class ClientUserModel {
  final String address;
  final String cpf;
  final String email;
  final String name;
  final String password;
  final String phone;

  const ClientUserModel({
    required this.address,
    required this.cpf,
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toBody() => {
        'email': email,
        'name': name,
        'phone': phone,
        'password': password,
        'cpf': cpf,
        'address': address,
      };
}
