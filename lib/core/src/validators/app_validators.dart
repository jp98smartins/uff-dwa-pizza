sealed class AppValidator {
  static const emailRegExp = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const emailErrorMessage = 'Digite um email válido!';
  static const passwordConfirmationErrorMessage = 'As senhas não coincidem!';

  static String? email(String? value) {
    if (value == null || value.isEmpty) return emailErrorMessage;

    if (!RegExp(emailRegExp).hasMatch(value)) return emailErrorMessage;

    return null;
  }

  static String? passwordConfirmation(String? value, String? password) {
    if (value == null || value.isEmpty) return passwordConfirmationErrorMessage;

    if (value != password) return passwordConfirmationErrorMessage;

    return null;
  }
}
