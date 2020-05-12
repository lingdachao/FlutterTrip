import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:myfluttertrip/model/travel_model.dart';

const TABS_URL = 'https://www.devio.org/io/flutter_app/json/travel_page.json';

var Params = {
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 2,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {
    "cid": "09031014111431397988",
    "ctok": "",
    "cver": "1.0",
    "lang": "01",
    "sid": "8888",
    "syscode": "09",
    "auth": null,
    "extension": [
      {
        "name": "protocal",
        "value": "https"
      }
    ]
  },
  "contentType": "json"
};

class TravelDao {
  static Future<TravelTabModel> fetch(String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Map params = Params["pagePara"];
    params["pageIndex"] = pageIndex;
    params["pageSize"] = pageSize;
    params["groupChannelCode"] = groupChannelCode;
    final response = await http.post(url,body: jsonEncode(params));
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();        //修复中文
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return result;
    }else{
      throw Exception('Fail to load travel_page.json');
    }
  }
}