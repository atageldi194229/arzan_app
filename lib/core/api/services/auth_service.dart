import 'package:tm/core/api/services/exceptions/unauthorized_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_path.dart';

class AuthService {
  Future<dynamic> login({
    required String username,
    required String password,
  }) async {
    var body = {
      "username": username,
      "password": password,
    };

    Uri uri = Uri.http(ApiPath.host, ApiPath.authLogin);

    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if ([200, 500].contains(response.statusCode)) {
      var parsed = jsonDecode(response.body);

      return parsed;
    } else {
      return "false";
      // throw Exception("Unknown api error");
    }
  }

  Future<dynamic> checkUser({String? username, String? phoneNumber}) async {
    var body = {};

    if (username != null) body["username"] = username;
    if (phoneNumber != null) body["phone_number"] = phoneNumber;

    Uri uri = Uri.http(ApiPath.host, ApiPath.authUserChecker);

    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Server error");
    }
  }

  Future<dynamic> getSmsData(String phoneNumber) async {
    var body = {
      'phone_number': phoneNumber,
    };

    Uri uri = Uri.http(ApiPath.host, ApiPath.authGetSmsData);

    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Server error");
    }
  }

  Future<dynamic> register({
    required String username,
    required String phoneNumber,
    required String password,
  }) async {
    var body = {
      "username": username,
      "phoneNumber": phoneNumber,
      "password": password,
      "custom_sms_service": true,
    };

    Uri uri = Uri.http(ApiPath.host, ApiPath.authRegister);

    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw Exception("Unknown api error");
    }
  }

  Future<dynamic> recoverPassword({
    required String phoneNumber,
    required String password,
  }) async {
    var body = {
      "phoneNumber": phoneNumber,
      "password": password,
      "custom_sms_service": true,
    };

    Uri uri = Uri.http(ApiPath.host, ApiPath.authRecoverPassword);

    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw Exception("Unknown api error");
    }
  }
}
