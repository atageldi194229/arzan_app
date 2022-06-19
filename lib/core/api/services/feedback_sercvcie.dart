import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_path.dart';

enum FeedbackType { complaint, contactMe, offer, official, thanks }

class FeedbackService {
  Future<bool> userFeedback({
    required String text,
    FeedbackType type = FeedbackType.complaint,
  }) async {
    try {
      Map<String, String> body = {
        "content": text,
        "type": type.name,
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

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
