import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) =>
      TextEditingValue(
        text: newValue.text.toUpperCase(),
        selection: newValue.selection,
      );
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) =>
      TextEditingValue(
        text: newValue.text.toLowerCase(),
        selection: newValue.selection,
      );
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += digitsOnly[i];
    }

    if (formatted.length > 10) {
      formatted = formatted.substring(0, 10);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
