import 'package:flutter/material.dart';
import 'package:knowledge_sharing/common/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonStyle {
  ///分割线
  static dynamic divider = Divider(
    color: Constant.lightGrey,
    height: 1,
  );

  static TextStyle topTabSelected() {
    return TextStyle(
      fontSize: Constant.font_size_32.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle title() {
    return TextStyle(
      fontSize: Constant.font_size_36.sp,
      fontWeight: FontWeight.bold,
      color: Constant.white,
    );
  }

  static TextStyle content() {
    return TextStyle(
      fontSize: Constant.font_size_28.sp,
      color: Constant.lightBlack,
    );
  }

  static TextStyle contentLightGrey() {
    return TextStyle(
      fontSize: Constant.font_size_28.sp,
      color: Constant.grey,
    );
  }

  static TextStyle notice() {
    return TextStyle(
      fontSize: Constant.font_size_28.sp,
      color: Constant.orange,
    );
  }

  static TextStyle textTitle() {
    return TextStyle(
      fontSize: Constant.font_size_32.sp,
      color: Constant.lightBlack,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle font32Dark() {
    return TextStyle(
      fontSize: Constant.font_size_32.sp,
      color: Constant.lightBlack,
    );
  }

  static TextStyle font32White() {
    return TextStyle(
      fontSize: Constant.font_size_32.sp,
      color: Constant.lightWhite,
    );
  }

   static TextStyle font32Grey() {
    return TextStyle(
      fontSize: Constant.font_size_32.sp,
      color: Constant.grey,
    );

    
  }

  static TextStyle textTitleLightBold() {
    return TextStyle(
      fontSize: Constant.font_size_32.sp,
      color: Constant.lightBlack,
      fontWeight: FontWeight.w500
    );
  }

  static TextStyle lightTime() {
    return TextStyle(
      fontSize: Constant.font_size_24.sp,
      color: Constant.lightWhite,
    );
  }
}
