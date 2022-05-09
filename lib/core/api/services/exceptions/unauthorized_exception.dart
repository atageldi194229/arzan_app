class UnauthorizedException implements Exception {
  final String message = "UnauthorizedException exception";

  @override
  toString() {
    return message;
  }
}
