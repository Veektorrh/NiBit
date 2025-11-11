import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:jollof/server/getxserver.dart';

class Stylings {
  //Colors
  static Color yellow = const Color(0xFFFEC706);
  static Color bgColor = const Color(0xFFFBFBFB);
  static Color black = Colors.black;

//textStyles
  static TextStyle titles = TextStyle(
    fontFamily: 'Inter',
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Get.isDarkMode? Colors.white :Colors.black
  );
  static TextStyle subTitles =  TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode? Colors.white :Colors.black
  );
  static TextStyle body =  TextStyle(
      fontFamily: 'Inter',
      fontSize: 11,
      color: Get.isDarkMode? Colors.white :Colors.black,
      fontWeight: FontWeight.w400
  );
//media
  static String imgPath = "assets/images";
}