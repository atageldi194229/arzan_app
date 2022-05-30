import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/index.dart';
import '../api_path.dart';
import 'api_client.dart';

class BannerService {
  Dio _client = Client().init();

  BannerService([Dio? client]) {
    _client = client ?? _client;
    // if (client != null) _client = client;
  }

  Future<List<BannerModel>> fetchData() async {
    // return [BannerModel(id: 1, image: "", keywords: "sdf", payload: "qwe")];

    Uri uri = Uri.http(
        ApiPath.host, ApiPath.getBanners, {"search": "app_banner_page%"});
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return parsed["banners"]
          .map<BannerModel>((e) => BannerModel.fromMap(e))
          .toList();
    } else {
      return [];
      // throw Exception("Unable to fetch data");
    }
  }

  Future<List<BannerModel>> fetchAllBanners() async {
    try {
      final response = await _client.get(
        ApiPath.getBanners,
        queryParameters: {"search": "app_banner_page%"},
      );

      var parsed = json.decode(response.data);

      return parsed["banners"]
          .map<BannerModel>((e) => BannerModel.fromMap(e))
          .toList();
    } on DioError catch (ex) {
      throw Exception("Dio Error on Service Provider ${ex.message}");
    }
  }
}
