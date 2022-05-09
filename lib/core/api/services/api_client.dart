import 'dart:async';
import 'package:tm/core/api/api_path.dart';
import "package:dio/dio.dart";

class Client {
  Dio init() {
    Dio _dio = Dio();
    _dio.interceptors.add(ApiInterceptors());
    _dio.options.baseUrl = ApiPath.httpsPath;
    return _dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    print("Dio error: ${err.message}");
  }

  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // do something before response

    if (response.statusCode == 500) throw Exception("Server error");
    if (response.statusCode == 404) throw Exception("Not found");
    if (response.statusCode == 403) throw Exception("Authorithation error");
    if (response.statusCode! > 210) throw Exception("Unknown api error");

    if ([200, 201].contains(response.statusCode)) return response;
  }
}
