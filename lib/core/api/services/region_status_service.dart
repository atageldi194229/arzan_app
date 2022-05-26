import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_path.dart';
import '../models/region_status.dart';



class RegionStatusService {
  Future<List<RegionStatusModel>> getRegions() async{ 

   Uri uri = Uri.http(ApiPath.host, ApiPath.region_status);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      
      return parsed["regions"].map<RegionStatusModel>((e) => RegionStatusModel.fromJson(e)).toList();
    } else {
      throw "Unable to fetch data";
    }
  }
  }
 