import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/home/test_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Container(
            child: Text("首页", style: CommonStyle.title()),
          ),
          centerTitle: true,
        ),
        body: _getBody());
  }

  Widget _getTabbar() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: TabBar(
        controller: _tabController,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Color(0xFFeb544d), width: 3),
          insets: EdgeInsets.symmetric(horizontal: 60),
        ),
        indicatorPadding: EdgeInsets.only(bottom: 20),
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

  Widget _getBody() {
    return Column(
      children: <Widget>[
        ///构建tabbar
        _getTabbar(),
        Container(
          height: 40,
          color: Color(0xFFfefbe8),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "关注微信公众号你我指数，各种专业知识推送!",
            style: CommonStyle.notice(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
              ),
              Container(
                width: 50,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        ///返回你要跳转的页面
                        return TestPage();
                      },
                    ));
                  },
                  child: Text("路由跳转"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
