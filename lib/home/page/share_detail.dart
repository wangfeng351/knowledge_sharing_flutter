import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/home/model/Share.dart';
import 'package:knowledge_sharing/home/page/download_page.dart';
import 'package:knowledge_sharing/http/api.dart';
import 'package:knowledge_sharing/http/http_util.dart';

class ShareDetail extends StatefulWidget {
  final id;
  ShareDetail(this.id);

  @override
  _ShareDetailState createState() => _ShareDetailState(this.id);
}

class _ShareDetailState extends State<ShareDetail> {
  final id;
  _ShareDetailState(this.id);

  dynamic share;
  bool isRequest = false;
  bool isExchange = false;

  @override
  void initState() {
    _getShareDetail(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "兑换",
          style: CommonStyle.title(),
        ),
        backgroundColor: Constant.mColor,
        centerTitle: true,
      ),
      body: isRequest == false
          ? Container()
          : Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 75,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${share['title']}",
                          style: CommonStyle.textTitle(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "作者: ${share['author']}",
                              style: CommonStyle.content(),
                            ),
                            Text(
                              "发布人: ${share['wxNickname']}",
                              style: CommonStyle.content(),
                            ),
                            Text(
                              "下载次数: ${share['buyCounts']}",
                              style: CommonStyle.content(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFeeeeee),
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              "${share['summary']}",
                              style: CommonStyle.content(),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "积分: ",
                                    style: CommonStyle.textTitle(),
                                  ),
                                  Text('￥ 70',
                                      style: TextStyle(
                                          color: Constant.mColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                    width: 120,
                                    height: 50,
                                    margin: EdgeInsets.fromLTRB(20, 0, 0, 5),
                                    child: FlatButton(
                                      onPressed: () {
                                        // _showDialog(share['title'],
                                        //     share['downloadUrl']);
                                        _exchangeShare(share['title'],
                                            share['downloadUrl']);
                                      },
                                      color: Constant.mColor,
                                      child: Text(
                                        isExchange ? "已兑换" : "兑换",
                                        style: CommonStyle.title(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> _getShareDetail(id) {
    print("获取到的id是: " + id.toString());
    HttpUtil.request(Api.shareDetail, {'id': id}, (code, msg, data) {
      if (code == 0) {
        share = data;
        isRequest = true;
        setState(() {});
        print("获取到的数据是: " + data.toString());
      }
    }, (error) => null);
  }

  Future _showDialog(String title, String url) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("兑换成功"),
          content: Text("您是否继续兑换?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                //关闭对话框并返回true
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DownloadPage(title, url);
                  },
                ));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _exchangeShare(String title, String url) {
    HttpUtil.request(Api.exchange, {"shareId": id, "userId": Constant.user.id},
        (code, msg, data) {
      isExchange = true;
      setState(() {});
      _showDialog(title, url);
    }, (error) => null);
  }
}
