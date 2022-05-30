import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_path.dart';

enum GlobalVarKeys { storeAppBuildVersion }

class GlobalVarService {
  Future<String?> getValue(String key) async {
    try {
      Uri uri = Uri.http(ApiPath.host, ApiPath.getGlobalVar + key);

      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var parsed = jsonDecode(response.body);

        if (parsed["globalVar"] == null) return null;

        return parsed["globalVar"]["value"];
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return null;
  }
}
