import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

abstract class MyTextStyle {
  static TextStyle get header => TextStyle();

  static TextStyle get bodyText => TextStyle(
        fontFamily: appFontFamily,
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
        color: secondaryFontColor,
      );

  static TextStyle get already => TextStyle(
        fontFamily: appFontFamily,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: whitetext,
      );

  static TextStyle get alreadybutton => TextStyle(
        fontFamily: appFontFamily,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      );

  static TextStyle get hinttext => TextStyle(
        fontFamily: appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: hintcolor,
      );

  static TextStyle get agreetext => TextStyle(
        fontFamily: appFontFamily,
        fontSize: 10.sp,
        color: underColor,
      );

  static TextStyle get button => TextStyle(
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w600,
        color: backgroundColor,
        fontStyle: FontStyle.normal,
        fontSize: 13.sp,
      );

  static TextStyle get button2 => TextStyle(
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w600,
      color: backgroundColor,
      fontStyle: FontStyle.normal,
      fontSize: 13.sp,
      letterSpacing: 0.8.sp);

  static TextStyle get button1 => TextStyle(
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w400,
        color: backgroundColor,
        letterSpacing: 2,
        fontStyle: FontStyle.normal,
        fontSize: 13.sp,
      );

  static TextStyle get smalltext => TextStyle(
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w500,
        color: whitetext,
        fontStyle: FontStyle.normal,
        fontSize: 10.sp,
      );

  static TextStyle get apptitle => TextStyle(
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w500,
        color: whitetext,
        fontStyle: FontStyle.normal,
        fontSize: 14.sp,
      );

// big text

  static TextStyle get bigtext => TextStyle(
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w600,
        color: whitetext,
        fontStyle: FontStyle.normal,
        fontSize: 16.sp,
      );

// big text1

  static TextStyle get bigtext1 => TextStyle(
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        fontStyle: FontStyle.normal,
        fontSize: 16.sp,
      );

  static TextStyle get formhinttext => TextStyle(
      color: Colors.white,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 12.sp);

  static TextStyle get formhinttext1 => TextStyle(
      color: Colors.black,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 12.sp);

  static TextStyle get hinttext2 => TextStyle(
      color: Color(0xffc5c5c5),
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 12.sp);

  static TextStyle get labelStyle => TextStyle(
      color: Colors.white,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 12.sp);

  static TextStyle get labelStyle1 => TextStyle(
      color: Colors.black,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 12.sp);

  static TextStyle get formtext => TextStyle(
      color: Colors.white,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 12.sp);

  static TextStyle get formtext1 => TextStyle(
      color: Colors.black,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 12.sp);

  static TextStyle get stepper => TextStyle(
      color: Colors.white,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 11.sp);

  static TextStyle get check => TextStyle(
      color: Colors.white,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 11.sp);

  static TextStyle get upgrade => TextStyle(
      color: Colors.black,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 11.sp);

  static TextStyle get signbtn => TextStyle(
      color: Colors.black,
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 11.sp);

  static TextStyle get small => TextStyle(
      color: Color(0xffa4a4a4),
      fontFamily: appFontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 11.sp);

// bigtext2
  static TextStyle get bigtext2 => TextStyle(
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w600,
        color: whitetext,
        fontStyle: FontStyle.normal,
        fontSize: 13.5.sp,
      );

  static TextStyle get drawerItemTitle => TextStyle(
        fontFamily: appFontFamily,
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        // color: MyAppColor.primaryFontColor,
      );

  static TextStyle get appBarText => TextStyle(
        fontFamily: appFontFamily,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        // color: MyAppColor.primaryFontColor,
      );

  static TextStyle get homeitalic => TextStyle(
        fontFamily: appFontFamily,
        fontStyle: FontStyle.italic,
        fontSize: 9.5.sp,
        fontWeight: FontWeight.w500,
        color: whitetext,
      );
       static TextStyle get scoutCard => TextStyle(
        fontFamily:appFontFamily,
        fontSize: 13.sp,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        color: Color(0xff2D3D62),
      );
static TextStyle get scoutCard1 => TextStyle(
        fontFamily: appFontFamily,
        fontSize: 12.sp,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        color: Color(0xff2D3D62),
      );
static TextStyle get scoutyear => TextStyle(
        fontFamily: appFontFamily,
        fontSize: 14.sp,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: Color(0xff2D3D62),
      );
      static TextStyle get bigitalic => TextStyle(
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w500,
        color: whitetext,
        fontStyle: FontStyle.italic,
        fontSize: 13.5.sp,
      );
      
  static TextStyle get mobilehome => TextStyle(
        fontFamily:appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: whitetext,
      );

  static TextStyle get mobilehomecolor => TextStyle(
        fontFamily:appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      );

  static TextStyle get secondtext => TextStyle(
      fontFamily:appFontFamily,
      fontStyle: FontStyle.normal,
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: whitetext,
      height: 1.5,
      letterSpacing: 0.8.sp);

  static TextStyle get colortext => TextStyle(
      fontFamily:appFontFamily,
      fontStyle: FontStyle.normal,
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: primaryColor,
      height: 1.5,
      letterSpacing: 0.8.sp);

  static TextStyle get Invocation => TextStyle(
        fontFamily:appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      );

  static TextStyle get aboutuscard => TextStyle(
        fontFamily:appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: backgroundColor,
      );

  static TextStyle get startfreebtn => TextStyle(
      fontFamily:appFontFamily,
      fontStyle: FontStyle.normal,
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: whitetext,
      height: 1.5,
      letterSpacing: 0.8.sp);

  static TextStyle get morecontainer => TextStyle(
        fontFamily:appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: whitetext,
      );

  static TextStyle get Useful => TextStyle(
        fontFamily:appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: whitetext,
      );

  static TextStyle get links => TextStyle(
        fontFamily:appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: whitetext,
      );

  static TextStyle get footer => TextStyle(
        fontFamily: appFontFamily,
        fontStyle: FontStyle.normal,
        fontSize: 9.sp,
        fontWeight: FontWeight.w400,
        color: whitetext,
      );

  static TextStyle get loginBodyText => TextStyle(
        fontFamily:appFontFamily,
        fontSize: 9.sp,
        fontWeight: FontWeight.w700,
        color: whitetext,
      );
}
