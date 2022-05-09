class NotFoundException implements Exception {
  final String message = "Not found exception";

  @override
  toString() {
    return message;
  }
}
