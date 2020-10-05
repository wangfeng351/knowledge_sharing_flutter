import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:knowledge_sharing/home/page/initial_page.dart';
import 'package:knowledge_sharing/login/page/login._page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: false);
    return MaterialApp(
      title: "知识分享",
      theme: ThemeData(
        platform: TargetPlatform.iOS
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
