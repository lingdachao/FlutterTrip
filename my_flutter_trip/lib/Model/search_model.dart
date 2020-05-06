class SearchModel {
  List<SearchItem> _data;
  String keyword;

  SearchModel({List<SearchItem> data, String keyword}) {
    this._data = data;
    this.keyword = keyword;
  }

  List<SearchItem> get data => _data;
  set data(List<SearchItem> data) => _data = data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = new List<SearchItem>();
      json['data'].forEach((v) {
        _data.add(new SearchItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchItem {
  String _code;
  String _word;
  String _type;
  String _districtname;
  String _url;
  String _price;
  String _zonename;
  String _star;

  SearchItem(
      {String code,
        String word,
        String type,
        String districtname,
        String url,
        String price,
        String zonename,
        String star}) {
    this._code = code;
    this._word = word;
    this._type = type;
    this._districtname = districtname;
    this._url = url;
    this._price = price;
    this._zonename = zonename;
    this._star = star;
  }

  String get code => _code;
  set code(String code) => _code = code;
  String get word => _word;
  set word(String word) => _word = word;
  String get type => _type;
  set type(String type) => _type = type;
  String get districtname => _districtname;
  set districtname(String districtname) => _districtname = districtname;
  String get url => _url;
  set url(String url) => _url = url;
  String get price => _price;
  set price(String price) => _price = price;
  String get zonename => _zonename;
  set zonename(String zonename) => _zonename = zonename;
  String get star => _star;
  set star(String star) => _star = star;

  SearchItem.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _word = json['word'];
    _type = json['type'];
    _districtname = json['districtname'];
    _url = json['url'];
    _price = json['price'];
    _zonename = json['zonename'];
    _star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['word'] = this._word;
    data['type'] = this._type;
    data['districtname'] = this._districtname;
    data['url'] = this._url;
    data['price'] = this._price;
    data['zonename'] = this._zonename;
    data['star'] = this._star;
    return data;
  }
}
