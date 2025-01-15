final class CredentialsModel {
  final String email;
  final String password;

  const CredentialsModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toBody() => {
        'email': email,
        'password': password,
      };
}
