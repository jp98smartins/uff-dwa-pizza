import '../interfaces/interfaces.dart';

/// Default configuration options to throw a timeout exception during a HTTP request.
final class AppTimeouts implements TimeoutOptions {
  @override
  Duration get connectTimeout => const Duration(seconds: 6);

  @override
  Duration get receiveTimeout => const Duration(seconds: 12);

  @override
  Duration get sendTimeout => const Duration(seconds: 9);
}
