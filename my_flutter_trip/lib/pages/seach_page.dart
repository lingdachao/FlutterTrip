import 'package:flutter/material.dart';
import 'package:myfluttertrip/Dao/search_dao.dart';
import 'package:myfluttertrip/Model/search_model.dart';
import 'package:myfluttertrip/util/navigator_util.dart';
import 'package:myfluttertrip/widget/search_bar.dart';
import 'package:myfluttertrip/widget/webview.dart';

const URL = 'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft = true, this.searchUrl = URL, this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {

  SearchModel searchModel;
  String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar,
          MediaQuery.removePadding(removeTop: true, context: context, child: Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: searchModel?.data?.length??0,
                itemBuilder: (BuildContext context, int position){
                  return _item(position);
                }),
          ))
        ],
      ),
    );
  }

  _item(int position){
    if(searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[position];
    return GestureDetector(
      onTap: (){
        NavigatorUtil.push(context,
            WebView(url: item.url,title: '详情')
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
        ),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: Text('${item.word} ${item.districtname??''} ${item.zonename??''}'),
                ),
                Container(
                  width: 300,
                  child: Text('${item.price??''} ${item.type??''}'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  _onTextChange(String text){
      keyword = text;
      if(text.length == 0){
        setState(() {
          searchModel = null;
        });
      }
      String url = widget.searchUrl + keyword;
      SearchDao.fetch(url,text).then((SearchModel model){
        //防止过快输入导致不同步。当前输入的关键字和网络请求回来的相同才渲染
        if(model.keyword != keyword){return;}
        setState(() {
          searchModel = model;
        });
      }).catchError((e){
        print(e);
      });

  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              hint: widget.hint,
              searchBarType: SearchBarType.normal,
             // inputBoxClick: _jumpToSearch,
             // speakClick: _jumpToSpeak,
              defaultText: '',
              leftButtonClick: (){
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        ),
        Container(
          height: 0.5 ,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

}