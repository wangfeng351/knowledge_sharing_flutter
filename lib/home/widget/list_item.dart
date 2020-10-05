import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/home/model/Share.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ListItem extends StatefulWidget {
  final List<Share> _shareLists;
  String testText;

  ListItem(this._shareLists, {this.testText});

  @override
  _ListItemState createState() => _ListItemState(this._shareLists);
}

class _ListItemState extends State<ListItem> {
  final List<Share> shareLists;
  _ListItemState(this.shareLists);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildListWidget(),
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
}
