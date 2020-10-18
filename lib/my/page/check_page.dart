import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/home/model/Share.dart';
import 'package:knowledge_sharing/home/page/download_page.dart';
import 'package:knowledge_sharing/home/page/share_detail.dart';
import 'package:knowledge_sharing/http/api.dart';
import 'package:knowledge_sharing/http/http_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  List<Share> notShares = List();
  int arrLen = 0;
  int pageIndex = 1;
  int pageSize = 10;
  EasyRefreshController refreshController;
  bool _switchSelected = true; //维护单选开关状态
  TextEditingController _notPassController;
  TextEditingController _isPassController;
  FocusNode _notPass = FocusNode();
  FocusNode _isPass = FocusNode();
  List<DropdownMenuItem<String>> _sorts = List();
  String _dropValue = '通过';
  List<String> dropList = <String>['通过', '不通过'];

  ///sortItems.add(DropdownMenuItem(value: '价格降序', child: Text('价格降序')));
  ///sortItems.add(DropdownMenuItem(value: '价格升序', child: Text('价格升序')));

  @override
  void initState() {
    _sorts.add(DropdownMenuItem(value: '价格降序', child: Text('价格降序')));
    _sorts.add(DropdownMenuItem(value: '价格升序', child: Text('价格升序')));
    _getShareList();
    _notPassController = TextEditingController();
    _isPassController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("帖子审核"),
        centerTitle: true,
      ),
      body: EasyRefresh(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          pageIndex = 0;
          _getData();
        },
        onLoad: () async {
          pageIndex += 1;
          _getData();
          refreshController.finishLoad(
              noMore: notShares.length % 10 == 0 && notShares.length == arrLen);
        },
        child: ListView(
          children: _buildListWidget(),
        ),
      ),
    );
  }

  ///构建列表
  List<Widget> _buildListWidget() {
    List<Widget> lists = List();
    for (int i = 0; i < notShares.length; i++) {
      lists.add(GestureDetector(
        onTap: () {
          if (notShares[i].downloadUrl == null) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                // return ShareDetail();
                return ShareDetail(notShares[i].id);
              },
            ));
          } else {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                // return ShareDetail();
                return DownloadPage(
                    notShares[i].title, notShares[i].downloadUrl);
              },
            ));
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 20.w),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFFe3e3e3), width: 1))),
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
                    backgroundImage: NetworkImage(notShares[i].cover),
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
                            notShares[i].title,
                            maxLines: 2,
                            style: CommonStyle.textTitle(),
                          ),
                          Expanded(
                            child: Text(
                              notShares[i].summary,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: FlatButton(
                        color: Constant.mColor,
                        onPressed: () {
                          checkout(notShares[i].id);
                        },
                        child: Text(
                          "审核",
                          style: CommonStyle.font32White(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
          notShares.add(share);
        }
        arrLen = notShares.length;
        setState(() {});
      } else {
        print("请求异常>>>>>" + msg);
      }
    }, (error) {
      print("请求出错" + error.toString());
    });
  }

  ///弹框
  Future<void> checkout(id) async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
            title: const Text('审核选项'),
            children: <Widget>[
              Container(
                height: 100.w,
                padding: EdgeInsets.fromLTRB(0.w, 10.w, 0.w, 10.w),

                ///在Column中若使用Container去包裹一个TextField，必须要给Container一个宽高，否则会报
                child: TextField(
                  focusNode: _isPass,
                  controller: _isPassController,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () {
                    _notPass.unfocus();
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CommonStyle.contentLightGrey(),
                      //设置内容边距
                      contentPadding: EdgeInsets.only(left: 20.w),
                      //设置边框圆润度
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "是否通过(NOT PASS 或 PASS)"),
                ),
              ),
              Container(
                height: 100.w,
                padding: EdgeInsets.fromLTRB(0.w, 10.w, 0.w, 10.w),

                ///在Column中若使用Container去包裹一个TextField，必须要给Container一个宽高，否则会报
                child: TextField(
                  focusNode: _notPass,
                  controller: _notPassController,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () {
                    _notPass.unfocus();
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CommonStyle.contentLightGrey(),
                      //设置内容边距
                      contentPadding: EdgeInsets.only(left: 20.w),
                      //设置边框圆润度
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "未通过原因"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("取消"),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      color: Constant.mColor,
                      onPressed: () {
                        comfirmCheckout(id);
                      },
                      child: Text("确认"),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  comfirmCheckout(id) {
    HttpUtil.request(Api.checkout + '/' + id.toString(), {
      "auditStatusEnum": _isPassController.text,
      "reason": _notPassController.text
    }, (code, msg, data) {
      print("审核");
      if (code == 0) {
        _getShareList();
        Navigator.pop(context);
        _notPassController.text = '';
        _isPassController.text = '';
        setState(() {});
      }
    }, (error) => null);
  }

  getSort() {}

  Future<void> _getShareList() {
    HttpUtil.getRequest(Api.notCheck, null, (code, msg, data) {
      if (code == 0) {
        notShares = List();
        Map<String, dynamic> map = Map();
        map['data'] = data;
        print("获取到的数据是: " + data.toString());
        for (int i = 0; i < data.length; i++) {
          Share share = Share.fromJson(data[i]);
          notShares.add(share);
        }
        setState(() {});
      }
    }, (error) => null);
  }
}
