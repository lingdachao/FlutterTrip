import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:myfluttertrip/model/travel_model.dart';

const TABS_URL = 'https://www.devio.org/io/flutter_app/json/travel_page.json';

///tabs大接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(TABS_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();        //修复中文
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print(TravelTabModel.fromJson(result).tabs.length);
      return TravelTabModel.fromJson(result);
    }else{
      throw Exception('Fail to load travel_page.json');
    }
  }
}