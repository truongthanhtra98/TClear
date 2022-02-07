import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_one/src/data_models/location.dart';

class PlaceService{

  static const mapKey = 'USejsslN7JEBkHFGgpCaNgycS2nhTokf4k1cRGhBOvI';
  //static const mapKey = 'RKp8KudsmW01oiRlJiVjlMUq_Zzb_mj0zg64Osb_0hQ';

  static Future<List<Location>> searchPlace(String query, Location location) async {
//    String url ="https://places.sit.ls.hereapi.com/places/v1/discover/search?"
//        "at=${location.lat},${location.lng}&q=$query&Accept-Language=vi&apiKey=$mapKey";
    String url ="https://discover.search.hereapi.com/v1/discover?"
        "at=${location.lat},${location.lng}&q=$query&limit=10&lang=VN&apiKey=$mapKey";
    print(url);
    var res = await http.get(url);
    if (res.statusCode == 200) {print('cho cai ${json.decode(res.body)}');
      return Location.parseLocationList(json.decode(res.body));
    } else {
      return new List();
    }
  }

}