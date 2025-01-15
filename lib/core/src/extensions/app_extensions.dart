import 'package:intl/intl.dart';

extension StringExtensions on String {
  String withParams(Object parameters) {
    String replacedMessage = this;

    if (parameters is Iterable) {
      for (var i = 0; i < parameters.length; i++) {
        replacedMessage = replacedMessage.replaceAll('{$i}', parameters.elementAt(i).toString());
      }
    } else {
      replacedMessage = replacedMessage.replaceAll('{0}', parameters.toString());
    }

    return replacedMessage;
  }

  String capitalizeFirstLetters() {
    final capitalized = split(' ')
        .map(
          (word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '',
        )
        .join(' ');

    return capitalized.replaceAll('De', 'de').replaceAll('Dos', 'dos').replaceAll('Da', 'da');
  }

  String sanitizeNumbers() {
    return replaceAll(RegExp(r'\D'), '');
  }

  String sanitizeLetters() {
    return replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }
}

extension NumExtensions on num {
  String format({int fractionDigits = 0}) {
    // Função auxiliar para adicionar separadores de milhar
    String formatWithThousandsSeparator(String number) {
      final regex = RegExp(r'\B(?=(\d{3})+(?!\d))');
      return number.replaceAllMapped(regex, (match) => '.');
    }

    // Define o sufixo (milhões, bilhões) e o divisor
    String suffix = '';
    double divisor = 1;

    if (this >= 1e9) {
      suffix = ' bi';
      divisor = 1e9;
    } else if (this >= 1e6) {
      suffix = ' mi';
      divisor = 1e6;
    }

    // Calcula o número formatado com casas decimais
    final dividedNumber = (this / divisor).toStringAsFixed(fractionDigits);
    final parts = dividedNumber.split('.');
    final integerPart = formatWithThousandsSeparator(parts[0]);

    // Formata a parte decimal (se houver)
    final decimalPart = fractionDigits > 0 ? ',${parts[1]}' : '';

    // Retorna o resultado formatado
    return '$integerPart$decimalPart$suffix';
  }
}

extension DoubleExtensions on double {
  String formatAsPercentage([int fractionDigits = 1]) {
    if (fractionDigits < 1) return '${(this * 100).round()}%';
    return '${(this * 100).toStringAsFixed(fractionDigits)}%';
  }
}

extension DateTimeExtensions on DateTime {
  static DateFormat get _dateFormat => DateFormat('dd/MM/yyyy');
  static DateFormat get _dateUSFormat => DateFormat('yyyy-MM-dd');
  static DateFormat get _timeFormat => DateFormat('HH:mm');
  static DateFormat get _timeWithSecondsFormat => DateFormat('HH:mm:ss');

  String formatDate() => _dateFormat.format(this);

  String formatUSDate() => _dateUSFormat.format(this);

  String formatTime({bool withSeconds = false}) {
    return withSeconds ? _timeWithSecondsFormat.format(this) : _timeFormat.format(this);
  }

  String formatDateTime({String separator = ' ', bool withSeconds = false}) {
    return '${formatDate()}$separator${formatTime(withSeconds: withSeconds)}';
  }
}
