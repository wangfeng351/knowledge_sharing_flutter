import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/my/page/my_contribution.dart';
import 'package:knowledge_sharing/my/page/my_exchange.dart';
import 'package:knowledge_sharing/my/page/score_detail.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的',
          style: CommonStyle.title(),
        ),
        centerTitle: true,
        backgroundColor: Constant.mColor,
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ///头像
          Container(
            width: 160.w,
            height: 160.w,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://static.veer.com/veer/static/resources/keyword/2020-02-19/533ed30de651499da1c463bca44b6d60.jpg"),
              radius: 20,
            ),
          ),
          SizedBox(
            height: 10.w,
          ),

          ///昵称
          Text(
            "陶然然",
            style: CommonStyle.content(),
          ),
          SizedBox(
            height: 10.w,
          ),
          Text("积分: " + "200", style: CommonStyle.content()),
          SizedBox(
            height: 20.w,
          ),
          Container(
            width: 100.w,
            height: 50.w,
            child: RaisedButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              color: Colors.green,
              child: Text(
                "签到",
                style: CommonStyle.lightTime(),
              ),
            ),
          ),
          _buildListView()
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          _buildListTile("我的兑换", MyExchange()),
          _buildListTile("积分明细", ScoreDetail()),
          _buildListTile("我的投稿", MyContribution()),
        ],
      ),
    );
  }

  Widget _buildListTile(String name, var className) {
    return
    InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return className;
                  },
                ),
              );
            },
            child: 
     Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Constant.lightGrey))),
      child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            name,
            style: CommonStyle.content(),
          ),
          trailing: Container(
            width: 30.w,
            child: RaisedButton(
              onPressed: () {},
              padding: EdgeInsets.all(0),
              color: Constant.lightWhite,
              elevation: 0,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Constant.grey,
                size: 28.sp,
              ),
            ),
          ),),),
    );
  }
}
