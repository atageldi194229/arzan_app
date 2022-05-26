import 'package:flutter/material.dart';

class ApiService {
  static Uri uriParse(
    String authority,
    String unencodedPath, [
    Map<String, dynamic>? queryParameters,
  ]) {
    String _queryString = "";

    if (queryParameters != null) {
      _queryString = Uri(
        queryParameters: queryParameters.map(
          (key, value) => MapEntry(key, value?.toString()),
        ),
      ).query;
    }

    debugPrint(_queryString);

    return Uri.parse(authority + unencodedPath + '?' + _queryString);
  }

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
