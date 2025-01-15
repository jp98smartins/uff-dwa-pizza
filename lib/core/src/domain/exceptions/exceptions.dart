import 'exception_tags.dart';

export 'exception_tags.dart';

final class AppException implements Exception {
  final String? segment;
  final String? step;
  final AppExceptionTags tag;
  final Map<String, dynamic>? extra;

  const AppException.business(
    this.tag, {
    this.segment,
    this.step,
    this.extra,
  });

  const AppException.network({
    this.segment,
    this.step,
    this.extra,
  }) : tag = AppExceptionTags.networkError;

  const AppException.unexpected({
    this.segment,
    this.step,
    this.extra,
  }) : tag = AppExceptionTags.unexpected;

  @override
  String toString() {
    var exception = 'AppException($tag)';

    if (segment != null) {
      exception += ' in $segment';
    }

    if (step != null) {
      exception += ' at $step';
    }

    return exception;
  }
}
