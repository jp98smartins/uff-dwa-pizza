/// Class of configuration options to throw a timeout exception during a HTTP request.
abstract interface class TimeoutOptions {
  /// The timeout duration to connect to the server.
  Duration get connectTimeout;

  /// The timeout duration to receive data from the server.
  Duration get receiveTimeout;

  /// The timeout duration to send data to the server.
  Duration get sendTimeout;
}
