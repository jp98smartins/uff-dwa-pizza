enum AppExceptionTags {
  invalidCredentials('INVALID_CREDENTIALS'),
  networkError('NETWORK_ERROR'),
  unexpected('UNEXPECTED');

  final String tag;

  const AppExceptionTags(this.tag);

  @override
  String toString() => tag;

  static AppExceptionTags parse(String tag) => AppExceptionTags.values.firstWhere(
        (element) => element.tag == tag,
        orElse: () => AppExceptionTags.unexpected,
      );

  static AppExceptionTags? tryParse(String tag) {
    try {
      return AppExceptionTags.values.firstWhere((element) => element.tag == tag);
    } on StateError catch (_) {
      return null;
    }
  }
}
