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
  ///选项卡控制器
  TabController _tabController;

  ///定义数据集合
  List<Share> shareLists = List();

  ///定义TextField焦点控制器
  FocusNode _searchFocus = FocusNode();

  int pageIndex = 0;
  int pageSize = 10;
  String testText = "hello";

  TextEditingController _keywords = TextEditingController();

  @override
  void initState() {
    _getData();

    ///初始化选项卡控制器，选项卡个数为2，默认显示第一个选项卡内容
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("重新进入build方法");
    print("获取到的数据是: " + shareLists.length.toString());
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

      ///设置宽为设备的宽
      width: MediaQuery.of(context).size.width,

      ///定义tab选项卡
      child: TabBar(
        controller: _tabController,

        ///自定义指示器
        indicator: UnderlineTabIndicator(
          ///设置指示器颜色及宽
          borderSide: BorderSide(color: Color(0xFFeb544d), width: 3),

          ///设置指示器横向内边距
          insets: EdgeInsets.symmetric(horizontal: 120.w),
        ),

        ///指示器与文章之间的距离
        indicatorPadding: EdgeInsets.only(bottom: 40.w),

        ///未选择时指示器的颜色
        unselectedLabelColor: Colors.grey,

        ///未选中时文本的样式
        unselectedLabelStyle: TextStyle(color: Colors.grey),

        ///文本的默认样式
        labelColor: Constant.lightBlack,
        tabs: <Widget>[
          Tab(
            ///手势组件
            child: InkWell(
              onTap: () {
                _searchFocus.unfocus();
                _tabController.index = 0;
              },
              child: Container(
                ///子组件对齐方式
                alignment: Alignment.center,
                width: 140.w,
                child: Text(
                  "发现",
                  style: CommonStyle.topTabSelected(),
                ),
              ),
            ),
          ),
          Tab(
            child: InkWell(
              onTap: () {
                _searchFocus.unfocus();

                ///点击事件，指定选项卡内容改变为第二个选项卡内容
                _tabController.index = 1;
              },
              child: Text("使用说明", style: CommonStyle.topTabSelected()),
            ),
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

        ///弹性组件, 若TabView、ListView这类组件嵌套在Column组件中，需要使用Expanded弹性组件包括，否则会报hasSize异常
        Expanded(
          ///与Tabbar连用，tabbar指定几个选项卡，则TabBarView的子组件的个数要对应起来
          child: TabBarView(
            ///选项卡控制器
            controller: _tabController,
            children: <Widget>[
              ///分割出去的组件
              _buildFindWidgt(),
              Container(
                ///内边距
                padding: EdgeInsets.all(40.w),

                ///文本组件
                child: Text(
                  "资源均为免费，兑换后即可查看下载地址: 点击我的 -> 我的兑换，即可查看、下载兑换的资源。",
                  style: CommonStyle.content(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFindWidgt() {
    print("获取到的数据是：" + shareLists.length.toString());
    return Column(
      children: <Widget>[
        Container(
          height: 80.w,
          color: Color(0xFFfefbe8),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 40.w),
          child: Text(
            "关注微信公众号你我之书，各种专业知识推送!" + testText,
            style: CommonStyle.notice(),
          ),
        ),
        Container(
          height: 80.w,
          padding: EdgeInsets.fromLTRB(40.w, 10.w, 40.w, 10.w),

          ///在Column中若使用Container去包裹一个TextField，必须要给Container一个宽高，否则会报
          child: TextField(
            focusNode: _searchFocus,
            controller: _keywords,
            textInputAction: TextInputAction.search,
            onEditingComplete: () {
              _search();
              _searchFocus.unfocus();
            },
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
          ///手势组件，包括点击、长按、拖拽等事件
          child: GestureDetector(
            onTap: () {
              ///失去焦点
              _searchFocus.unfocus();
            },
            onPanDown: (value) {
              _searchFocus.unfocus();
            },
            child: Container(
              ///设置指定上部外边距
              margin: EdgeInsets.only(top: 20.w),

              ///引入自定义组件,传入对应的值
              child: ListView(
                children: _buildListWidget(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///构建列表
  List<Widget> _buildListWidget() {
    List<Widget> lists = List();
    for (int i = 0; i < shareLists.length; i++) {
      lists.add(Container(
        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 20.w),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Color(0xFFe3e3e3), width: 1))),
        height: 160.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 120.w,
                height: 120.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(shareLists[i].cover),
                )),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          shareLists[i].title,
                          maxLines: 2,
                          style: CommonStyle.textTitle(),
                        ),
                        Expanded(
                          child: Text(
                            shareLists[i].summary,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(shareLists[i].price.toString() + "积分"),
                        Text(Constant.user != null
                            ? Constant.user.wxNickname != shareLists[i].author
                                ? "兑换"
                                : "下载"
                            : "兑换"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return lists;
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

  ///请求接口，获取数据
  Future<void> _search() async {
    shareLists = List<Share>();

    ///第一个参数是你的接口名
    HttpUtil.request(Api.search, {
      "pageSize": pageSize,
      "pageIndex": pageIndex,
      "keywords": _keywords.text
    }, (code, msg, data) {
      if (code == 0) {
        for (int i = 0; i < data.length; i++) {
          Share share = Share.fromJson(data[i]);
          shareLists.add(share);
        }
        print("分享信息的列表条数是: " + shareLists.length.toString());
        setState(() {});
      } else {
        print("请求异常>>>>>" + msg);
      }
    }, (error) {
      print("请求出错" + error.toString());
    });
  }
}
