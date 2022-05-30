import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_path.dart';

class FeedbackService {
  Future<bool> userFeedback(String feedback) async {
    try {
      Map<String, String> body = {
        "content": feedback,
        "type": "complaint",
      };

      Uri uri = Uri.http(ApiPath.host, ApiPath.createFeedback);

      var response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer: ${ApiPath.userToken}",
        },
        body: jsonEncode(body),
      );

      debugPrint("response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        jsonDecode(response.body);
        debugPrint("successflully added");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
