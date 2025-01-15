import '../interfaces/interfaces.dart';

/// Default configuration options to throw a timeout exception during a HTTP request.
final class AppCustomTimeouts implements TimeoutOptions {
  final int connect;
  final int receive;
  final int send;

  const AppCustomTimeouts({
    required this.connect,
    required this.receive,
    required this.send,
  });

  @override
  Duration get connectTimeout => Duration(seconds: connect);

  @override
  Duration get receiveTimeout => Duration(seconds: receive);

  @override
  Duration get sendTimeout => Duration(seconds: send);
}
