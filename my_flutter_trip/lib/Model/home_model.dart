import 'package:myfluttertrip/Model/common_model.dart';
import 'package:myfluttertrip/Model/config_model.dart';
import 'package:myfluttertrip/Model/grid_nav_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;

  HomeModel({this.config, this.bannerList, this.localNavList, this.gridNav});

}