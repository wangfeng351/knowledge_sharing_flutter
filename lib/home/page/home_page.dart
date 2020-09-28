import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/home/model/Share.dart';
import 'package:knowledge_sharing/home/widget/list_item.dart';
import 'package:knowledge_sharing/http/api.dart';
import 'package:knowledge_sharing/http/http_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  ///定义数据集合
  List<Share> shareLists = List();

  int pageIndex = 0;
  int pageSize = 10;

  @override
  void initState() {
    _getData();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.mColor,
          title: Container(
            child: Text("首页", style: CommonStyle.title()),
          ),
          centerTitle: true,
        ),
        body: _buildBody());
  }

  Widget _buildTabbar() {
    return Container(
      height: 80.w,
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        controller: _tabController,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Color(0xFFeb544d), width: 3),
          insets: EdgeInsets.symmetric(horizontal: 120.w),
        ),
        indicatorPadding: EdgeInsets.only(bottom: 40.w),
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        labelColor: Colors.black,
        tabs: <Widget>[
          Tab(
            child: Text(
              "发现",
              style: CommonStyle.topTabSelected(),
            ),
          ),
          Tab(
            child: Text("使用说明", style: CommonStyle.topTabSelected()),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        ///构建tabbar
        _buildTabbar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _buildFindWidgt(),
              Container(
                padding: EdgeInsets.all(40.w),
                child: Text("资源均为免费，兑换后即可查看下载地址: 点击我的 -> 我的兑换，即可查看、下载兑换的资源。", style: CommonStyle.content(),),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFindWidgt() {
    return Column(
      children: <Widget>[
        Container(
          height: 80.w,
          color: Color(0xFFfefbe8),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 40.w),
          child: Text(
            "关注微信公众号你我之书，各种专业知识推送!",
            style: CommonStyle.notice(),
          ),
        ),
        Container(
          height: 80.w,
          padding: EdgeInsets.fromLTRB(40.w, 10.w, 40.w, 10.w),
          child: TextField(
            decoration: InputDecoration(

                ///前缀图标
                prefixIcon: Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Image.asset(
                    "images/search.png",
                    fit: BoxFit.cover,
                  ),
                ),

                ///设置前缀图片的容器大小
                prefixIconConstraints: BoxConstraints(
                  maxWidth: 60.w,
                  maxHeight: 40.w,
                ),
                filled: true,
                fillColor: Colors.white,
                hintStyle: CommonStyle.contentLightGrey(),
                //设置内容边距
                contentPadding: EdgeInsets.only(left: 20.w),
                //设置边框圆润度
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none),
                hintText: "请输入关键词"),
          ),
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(top: 20.w),
              child: ListItem(shareLists)),
        ),
      ],
    );
  }

  ///请求接口，获取数据
  Future<void> _getData() async {
    ///第一个参数是你的接口名
    HttpUtil.request(
        Api.getShareInfo, {"pageSize": pageSize, "pageIndex": pageIndex},
        (code, msg, data) {
      if (code == 0) {
        for (int i = 0; i < data.length; i++) {
          Share share = Share.fromJson(data[i]);
          shareLists.add(share);
        }
        setState(() {});
      } else {
        print("请求异常>>>>>" + msg);
      }
    }, (error) {
      print("请求出错" + error.toString());
    });
  }
}
