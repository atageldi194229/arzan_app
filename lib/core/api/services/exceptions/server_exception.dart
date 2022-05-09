class ServerException implements Exception {
  final String message = "Server exception";

  @override
  toString() {
    return message;
  }
}
