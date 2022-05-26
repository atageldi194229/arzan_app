import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/index.dart';
import '../api_path.dart';

class NotificationService {
  Future<List<NotificationModel>> fetchData({
    int? limit,
    int? offset,
  }) async {
    // return [Banner(id: 1, image: "", keywords: "sdf", payload: "qwe")];

    Uri uri = Uri.http(
      ApiPath.host,
      ApiPath.getNotifications,
      {
        'limit': (limit ?? 50).toString(),
        'offset': (offset ?? 0).toString(),
      },
    );
    var response = await http.get(uri, headers: {
      "Authorization": "Bearer: ${ApiPath.userToken}",
    });

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return parsed["notifications"]
          .map<NotificationModel>((e) => NotificationModel.fromMap(e))
          .toList();
    } else {
      throw Exception("Unable to fetch data");
    }
  }
}
