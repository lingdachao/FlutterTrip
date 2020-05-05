import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myfluttertrip/Dao/home_dao.dart';
import 'package:myfluttertrip/Model/common_model.dart';
import 'package:myfluttertrip/Model/grid_nav_model.dart';
import 'package:myfluttertrip/Model/home_model.dart';
import 'package:myfluttertrip/Model/sales_box_model.dart';
import 'package:myfluttertrip/util/navigator_util.dart';
import 'package:myfluttertrip/widget/grid_nav.dart';
import 'package:myfluttertrip/widget/loadding_container.dart';
import 'package:myfluttertrip/widget/local_nav.dart';
import 'package:myfluttertrip/widget/sales_box.dart';
import 'package:myfluttertrip/widget/sub_nav.dart';
import 'package:myfluttertrip/widget/webview.dart';
import 'package:myfluttertrip/util/navigator_util.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  double appBarAlpha = 0;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel = GridNavModel();
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox = SalesBoxModel();
  bool _Loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    try{
      HomeModel model = await HomeDao.fetch();
      setState(() {
          _Loading = false;
          bannerList = model.bannerList;
          localNavList = model.localNavList;
          gridNavModel = model.gridNav;
          subNavList = model.subNavList;
          salesBox = model.salesBox;
      });
    }catch(e){
      setState(() {
        _Loading = false;
      });
      print(e);
    }
  }

  _onScroll(offset){
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha < 0){
      alpha = 0;
    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(alpha);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Stack 越下面的元素，越在外围
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(isLoading: _Loading,cover: false, child: Stack(
        children: <Widget>[
          //MediaQuery.removePadding 移除顶部padding
          //NotificationListener监听listview滚动
          MediaQuery.removePadding(context: context, removeTop: true, child: NotificationListener(
            // ignore: missing_return
            onNotification: (scrollNotification){//depth 最外围元素
              if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                _onScroll(scrollNotification.metrics.pixels);
              }
            },
            child: _listView
          )),
          _appBar
        ],
      ))
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        Container(
          height: 240,
          child: Swiper(
              itemCount: bannerList.length,
              autoplay: true,
              itemBuilder: (BuildContext context, int index){
                CommonModel model = bannerList[index];
                return GestureDetector(
                  onTap: () {
                    NavigatorUtil.push(
                        context,
                        WebView(
                          url: model.url,
                          statusBarColor: model.statusBarColor,
                          hideAppBar: model.hideAppBar,
                        ));
                  },
                  child: Image.network(
                      model.icon,
                      fit: BoxFit.fill),
                );
              },
              pagination: SwiperPagination()
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child:  GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child:  SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child:  SalesBox(salesBox: salesBox),
        )
      ],
    );
  }

  Widget get _appBar {
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(padding: EdgeInsets.only(top: 20),child: Text('首页'),),
        ),
      ),
    );
  }
}