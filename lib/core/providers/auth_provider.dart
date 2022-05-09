import 'package:tm/core/api/api_path.dart';
import 'package:tm/core/api/services/auth_service.dart';
import 'package:tm/core/api/services/exceptions/unauthorized_exception.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  initData() {
    _prefs.then((prefs) {
      _username = prefs.getString("USER_USERNAME") ?? "";
      _password = prefs.getString("USER_PASSWORD") ?? "";

      if (_username.isNotEmpty && _password.isNotEmpty) {
        login(username: _username, password: _password);
      }
    });
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? token;
  bool isLoggedIn = false;
  int userId = 0;
  String username = "";
  String _username = "";
  String _password = "";

  setToken(value) {
    token = value;
    ApiPath.userToken = value;
    notifyListeners();
  }

  _saveInCache() {
    ApiPath.userToken = token ?? "";

    _prefs.then((prefs) {
      prefs.setInt("USER_ID", userId);
      prefs.setString("USER_TOKEN", token!);

      prefs.setString("USER_USERNAME", _username);
      prefs.setString("USER_PASSWORD", _password);
    });
  }

  logout() {
    isLoggedIn = false;
    ApiPath.userToken = "";

    notifyListeners();

    _prefs.then((prefs) {
      prefs.remove("USER_ID");
      prefs.remove("USER_TOKEN");

      prefs.remove("USER_USERNAME");
      prefs.remove("USER_PASSWORD");
    });
  }

  _handleResponseData({
    required dynamic responseData,
    Function? onDone,
  }) {
    if (responseData["success"] == true) {
      isLoggedIn = true;

      if (responseData['user'] is Map) {
        Map<String, dynamic> _user = responseData["user"];

        userId = _user["id"];
        username = _user["username"];
      }

      token = responseData["token"].toString();

      print(token);
      print("LOGIN DONE");

      _saveInCache();

      if (onDone != null) onDone();

      notifyListeners();
      print("user: ${responseData['user']['username']}");
    } else {
      print("error message: ${responseData['error']}");

      // if (responseData["errorCode"] == 11) {
      //   // print("Username or Password is invalid");
      // } else if (responseData["errorCode"] == 10) {
      //   // print("User not found");
      // }
    }
  }

  login({
    required String username,
    required String password,
    VoidCallback? onLogin,
  }) {
    AuthService()
        .login(
      username: username,
      password: password,
    )
        .then((res) async {
      // save credentials
      _username = username;
      _password = password;

      // handle response data
      _handleResponseData(
        responseData: res,
        onDone: onLogin,
      );
    }).catchError((err) {
      print(err.message);
    });
  }

  register({
    required String username,
    required String phoneNumber,
    required String password,
    required Function notYet,
    required Function onRegister,
  }) async {
    AuthService()
        .register(
      username: username,
      phoneNumber: phoneNumber,
      password: password,
    )
        .then((responseBody) {
      // save credentials
      _username = username;
      _password = password;

      // handle response data
      _handleResponseData(
        responseData: responseBody,
        onDone: onRegister,
      );
    }).catchError((error) {
      if (error is UnauthorizedException) {
        notYet();
      } else {
        // throw error
      }
    });
  }

  recoverPassword({
    required String phoneNumber,
    required String password,
    required Function notYet,
    required Function onRecoverPassword,
  }) async {
    AuthService()
        .recoverPassword(
      phoneNumber: phoneNumber,
      password: password,
    )
        .then((responseBody) {
      // save credentials
      _username = username;
      _password = password;

      // handle response data
      _handleResponseData(
        responseData: responseBody,
        onDone: onRecoverPassword,
      );
    }).catchError((error) {
      if (error is UnauthorizedException) {
        notYet();
      } else {
        // throw error
      }
    });
  }
}
