import 'package:dio/dio.dart';

class ApiService {
  static Uri createUri(
    String authority,
    String unencodedPath, {
    secure = true,
    Map<String, dynamic>? queryParameters,
  }) {
    if (secure) {
      return Uri.https(authority, unencodedPath, queryParameters);
    }

    return Uri.http(authority, unencodedPath, queryParameters);
  }

  static fetchData() {
    // var dio = Dio();

    // dio.get();
  }
}
