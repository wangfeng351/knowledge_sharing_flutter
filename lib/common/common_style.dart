import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/constant.dart';

class CommonStyle {
  static TextStyle topTabSelected() {
    return TextStyle(
      fontSize: Constant.font_size_16,
      fontWeight: FontWeight.bold,
      color: Constant.lightBlack,
    );
  }

  static TextStyle title() {
    return TextStyle(
      fontSize: Constant.font_size_20,
      fontWeight: FontWeight.bold,
      color: Constant.white,
    );
  }

  static TextStyle content() {
    return TextStyle(
      fontSize: Constant.font_size_14,
      color: Constant.lightBlack,
    );
  }

  static TextStyle notice() {
    return TextStyle(
      fontSize: Constant.font_size_14,
      color: Constant.orange,
    );
  }
}
