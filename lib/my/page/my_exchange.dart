import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/home/model/Share.dart';
import 'package:knowledge_sharing/home/widget/list_item.dart';
import 'package:knowledge_sharing/http/api.dart';
import 'package:knowledge_sharing/http/http_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyExchange extends StatefulWidget {
  @override
  _MyExchangeStaet createState() => _MyExchangeStaet();
}

class _MyExchangeStaet extends State<MyExchange> {
  List<Share> exchangeList = List<Share>();

  int pageIndex = 0;
  int pageSize = 10;

  @override
  void initState() {
    getSharesByUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的兑换", style: CommonStyle.title(),),
        backgroundColor: Constant.mColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.w),
        child: ListItem(exchangeList),
      ),
    );
  }

  void getSharesByUserId() {
    ///get请求，路径参数为登录者id
    HttpUtil.getRequest(Api.getExchangeShareInfo + "/" + Constant.user.id.toString(), null,
        (code, msg, data) {
      for (int i = 0; i < data.length; i++) {
        Share share = Share.fromJson(data[i]);
        exchangeList.add(share); 
        setState(() {});
        print("share的信息是>>>>" + exchangeList[0].cover);
      }
    }, (error) => null);
  }
}
