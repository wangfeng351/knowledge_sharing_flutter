import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/common_style.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:knowledge_sharing/home/page/initial_page.dart';
import 'package:knowledge_sharing/http/api.dart';
import 'package:knowledge_sharing/http/http_util.dart';
import 'package:knowledge_sharing/login/model/user.dart';
import 'package:knowledge_sharing/util/sp_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ///账号
  TextEditingController _account = TextEditingController();

  ///密码
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/bg.jpg"),
          fit: BoxFit.fill,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "知识分享",
              style: TextStyle(
                  color: Color(0xFF3d8d69),
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "账号:",
                  style: CommonStyle.font32White(),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 30,
                  width: 300,
                  child: TextField(
                    controller: _account,
                    style: TextStyle(color: Constant.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("密码:", style: CommonStyle.font32White()),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 30,
                  width: 300,
                  child: TextField(
                    controller: _password,
                    style: TextStyle(color: Constant.white),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              width: 350,
              height: 40,
              child: FlatButton(
                color: Constant.mColor,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  _login();
                },
                child: Text("登录"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login() {
    HttpUtil.request(
        Api.login, {"account": _account.text, "password": _password.text},
        (code, msg, data) {
      if (code == 0) {
        print("获取到的用户信息是");
        print(data['user']);
        print(data['token']);
        print("获取到的用户信息是");
        User user = User.fromJson(data['user']);
        SpUtil.putObject("user", user);
        SpUtil.putBool('isLogin', data['signIn']);
        SpUtil.putObject("token", data['token']['token']);
        Constant.token = data['token']['token'];
        Constant.isSignIn = data['signIn'];
        Constant.user = user;
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return InitialPage();
          },
        ));
      }
    }, (error) => null);
  }
}
