import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tm/core/api/models/global_var.dart';
import 'dart:convert';
import '../api_path.dart';

enum GlobalVarKeys { storeAppBuildVersion }

class GlobalVarService {
  Future<GlobalVar?> getValue(String key) async {
    try {
      Uri uri = Uri.http(ApiPath.host, ApiPath.getGlobalVar + key);

      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var parsed = jsonDecode(response.body);

        if (parsed["globalVar"] == null) return null;

        return GlobalVar.fromMap(parsed["globalVar"]);

        // return parsed["globalVar"]["value"];
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return null;
  }
}
