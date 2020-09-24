import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContributionPage extends StatefulWidget {
  @override
  _ContributionPageState createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("投稿"),
        centerTitle: true,
      ),
    );
  }
}
