import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  List _imageUrls = [
    'https://p9-dcd.byteimg.com/img/tos-cn-i-0000/c4dfdd5a0aa64173acb6d2ec23b7aa2e~tplv-resize:1024:0.jpg',
    'https://p3-dcd.byteimg.com/img/tos-cn-i-0000/0d13f526181b41b5828abf7a2ea4a092~tplv-resize:1024:0.jpg',
    'https://p1-dcd.byteimg.com/img/tos-cn-i-0000/188fc25eaad04adbabcde6c5a10e1b64~tplv-resize:1024:0.jpg'
  ];

  double appBarAlpha = 0;

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
      body: Stack(
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
            child: ListView(
              children: <Widget>[
                Container(
                  height: 240,
                  child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index){
                        return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill);
                      },
                      pagination: SwiperPagination()
                  ),
                ),
                Container(
                  height: 800,
                  child: Text("首页"),
                )
              ],
            ),
          ),),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(padding: EdgeInsets.only(top: 20),child: Text('首页'),),
              ),
            ),
          )
        ],
      )
    );
  }

}