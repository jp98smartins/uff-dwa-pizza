sealed class AppValidator {
  static const emailRegExp = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const emailErrorMessage = 'Digite um email válido!';
  static const passwordConfirmationErrorMessage = 'As senhas não coincidem!';
  static const requiredErrorMessage = 'Campo obrigatório!';
  static const phoneRegExp = r'^\(\d{2}\) \d{4,5}-\d{4}$';
  static const phoneErrorMessage = 'Digite um telefone válido!';
  static const cpfRegExp = r'^\d{3}\.\d{3}\.\d{3}-\d{2}$';
  static const cpfErrorMessage = 'Digite um CPF válido!';

  static String? creditCardNumber(String? value) {
    if (value == null || value.isEmpty) return requiredErrorMessage;

    if (value.replaceAll(' ', '').length != 16) return 'Digite um número de cartão válido!';

    return null;
  }

  static String? cpf(String? value) {
    if (value == null || value.isEmpty) return requiredErrorMessage;

    if (value.length != 14) return cpfErrorMessage;
    if (!RegExp(cpfRegExp).hasMatch(value)) return emailErrorMessage;
    if (!_isValidCpf(value)) return emailErrorMessage;

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return requiredErrorMessage;

    if (!RegExp(emailRegExp).hasMatch(value)) return emailErrorMessage;

    return null;
  }

  static String? money(String? value) {
    if (value == null || value.isEmpty) return requiredErrorMessage;

    if (value.length < 5 || double.tryParse(value.replaceAll(',', '.')) == null) return 'Digite um valor válido!';

    return null;
  }

  static String? passwordConfirmation(String? value, String? password) {
    if (value == null || value.isEmpty) return requiredErrorMessage;

    if (value != password) return passwordConfirmationErrorMessage;

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return requiredErrorMessage;

    if (!RegExp(phoneRegExp).hasMatch(value)) return phoneErrorMessage;

    return null;
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty) return requiredErrorMessage;

    return null;
  }

  static bool _isValidCpf(String value) {
    // Remove non-numeric characters
    value = value.replaceAll(RegExp(r'\D'), '');

    if (value.length != 11) return false;

    // Check for known invalid CPFs
    if (RegExp(r'^(\d)\1*$').hasMatch(value)) return false;

    // Validate first digit
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(value[i]) * (10 - i);
    }
    final firstDigit = (sum * 10 % 11) % 10;
    if (firstDigit != int.parse(value[9])) return false;

    // Validate second digit
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(value[i]) * (11 - i);
    }
    final secondDigit = (sum * 10 % 11) % 10;
    if (secondDigit != int.parse(value[10])) return false;

    return true;
  }
}
