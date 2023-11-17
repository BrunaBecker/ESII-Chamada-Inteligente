class EntityNotFoundException implements Exception {
  EntityNotFoundException({
    this.message = "Entity not found.",
  });

  final String message;

  @override
  String toString() => message;
}
