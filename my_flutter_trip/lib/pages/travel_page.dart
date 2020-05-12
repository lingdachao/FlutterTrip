import 'package:flutter/material.dart';
import 'package:myfluttertrip/dao/travel_dao.dart';
import 'package:myfluttertrip/dao/travel_tab_dao.dart';
import 'package:myfluttertrip/model/travel_model.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();

}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel = TravelTabModel();

  @override
  void initState() {
  _controller = TabController(length: 0, vsync: this);
  TravelTabDao.fetch().then((TravelTabModel model){
    //fix tabbar 不刷新的bug
    _controller = TabController(length: model.tabs.length, vsync: this);
    print(model.tabs.length);
    setState(() {
      tabs = model.tabs;
      travelTabModel = model;
    });
  }).catchError((e){
    print(e);
  });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Color(0xff2fcbdd), width: 3),
                insets: EdgeInsets.only(bottom: 10),
              ),
              labelColor: Colors.black,
              tabs: tabs.map<Tab>((TravelTab tab){
                print(tab.labelName);
                return Tab(text: tab.labelName);
              }).toList(),
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((TravelTab tab){
                return Text(tab.groupChannelCode);
              }).toList(),
            ),
          )
        ],
      )
    );
  }

}