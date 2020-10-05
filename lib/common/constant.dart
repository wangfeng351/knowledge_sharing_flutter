import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:knowledge_sharing/login/model/user.dart';
import 'package:knowledge_sharing/util/sp_util.dart';

class Constant {
  ///字体常量
  static const double font_size_24 = 24;
  static const double font_size_28 = 28;
  static const double font_size_32 = 32;
  static const double font_size_36 = 36;
  static const double font_size_40 = 40;

  ///主色
  static Color mColor = Color(0xFFeb544d);

  ///常用字体颜色
  ///浅黑
  static Color lightBlack = Color(0xFF323232);

  ///灰色
  static Color grey = Colors.grey;

  ///浅灰
  static Color lightGrey = Color(0xFFe3e3e3);

  ///浅白
  static Color lightWhite = Color(0xFFfdfdfd);

  ///白色
  static Color white = Colors.white;

  ///蓝色
  static Color blue = Color(0xFF4087f1);

  ///橘色
  static Color orange = Color(0xFFe2894d);

  ///定义全局变量user
  static User user = new User();
}
