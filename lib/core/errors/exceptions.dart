class TimeoutException implements Exception {
  final String message;
  TimeoutException([this.message = 'Request timed out']);
}