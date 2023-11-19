class NoApiResponseException implements Exception {
  NoApiResponseException({
    this.message = "No API response received.",
  });

  final String message;

  @override
  String toString() => message;
}
