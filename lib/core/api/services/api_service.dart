import 'package:flutter/material.dart';

class ApiService {
  static Uri uriParse(
    String authority,
    String unencodedPath, [
    Map<String, dynamic>? queryParameters,
  ]) {
    String queryString = "";

    if (queryParameters != null) {
      queryString = Uri(
        queryParameters: queryParameters.map(
          (key, value) => MapEntry(key, value?.toString()),
        ),
      ).query;
    }

    debugPrint(queryString);

    return Uri.parse('$authority$unencodedPath?$queryString');
  }
}
