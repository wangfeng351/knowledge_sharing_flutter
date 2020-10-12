import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/http/api.dart';
import 'package:knowledge_sharing/http/http_util.dart';
import 'package:knowledge_sharing/my/model/bonus_log.dart';

class ScoreDetail extends StatefulWidget {
  @override
  _ScoreDetailState createState() => _ScoreDetailState();
}

class _ScoreDetailState extends State<ScoreDetail> {
  ///定义日志集合
  List<BonusLog> bonusList = List();

  @override
  void initState() {
    getBonusByUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("积分明细", style: CommonStyle.title()),
        backgroundColor: Constant.mColor,
      ),
      body: ListView.builder(
        itemCount: bonusList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Constant.lightGrey))),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.access_time),
                  Text("${bonusList[index].createTime}" + " ${bonusList[index].description}")
                ],
              ),
              trailing: Text("20"),
            ),
          );
        },
      ),
    );
  }

  void getBonusByUserId() {
    HttpUtil.getRequest(Api.bonusDetail + "/" + Constant.user.id.toString(), null, (code, msg, data) {
      for (int i = 0; i < data.length; i++) {
        BonusLog bonusLog = BonusLog.fromJson(data[i]);
        bonusList.add(bonusLog);
      }
      setState(() {});
    }, (error) => null);
  }
}
