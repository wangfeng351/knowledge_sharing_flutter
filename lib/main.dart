import 'package:flutter/material.dart';
import 'package:knowledge_sharing/home/initial_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.iOS
      ),
      debugShowCheckedModeBanner: false,
      home: InitialPage(),
    );
  }
}
