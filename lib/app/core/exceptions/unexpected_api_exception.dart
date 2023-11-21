class UnexpectedApiException implements Exception {
  UnexpectedApiException({
    this.message = "An unexpected error in server, check your server side",
  });

  final String message;

  @override
  String toString() => message;
}
