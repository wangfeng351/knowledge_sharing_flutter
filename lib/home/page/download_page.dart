import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';

class DownloadPage extends StatefulWidget {
  final title;
  final url;

  DownloadPage(this.title, this.url);
  @override
  _DownLoadPageState createState() => _DownLoadPageState(title, url);
}

class _DownLoadPageState extends State<DownloadPage> {
  final title;
  final url;
  _DownLoadPageState(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
        centerTitle: true,
        backgroundColor: Constant.mColor,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${title}",
              style: CommonStyle.textTitle(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "下载地址:${url}",
              style: CommonStyle.font32Dark(),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 300,
                child: FlatButton(
                  color: Color(0xFF45d345),
                  onPressed: () {},
                  child: Text(
                    "复制下载地址",
                    style: CommonStyle.title(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
