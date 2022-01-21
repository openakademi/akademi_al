import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextTypes { p1, p2, d1, d2, t1, t2, h3, h2, h1, h6, h5, h4 }

const fontFamily = "Inter";
final defaultTextStyles = {
  TextTypes.p1: TextStyle(
      height: 1.64,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 17.0.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -0.75.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.p2: TextStyle(
      height: 1.64,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16.0.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -0.5.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.d1: TextStyle(
      height: 1.29,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14.0.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -0.25.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.d2: TextStyle(
      height: 0.94,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 12.0.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -0.25.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.h3: TextStyle(
      height: 2.35,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 30.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -1.15.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.h2: TextStyle(
      height: 2.94,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 40.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -1.5.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.h1: TextStyle(
      height: 3.7,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 52.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -2.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.t1: TextStyle(
      height: 2,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 24.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -1.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.t2: TextStyle(
      height: 1.52,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 20.sp,
      color: Color.fromRGBO(26, 32, 44, 1),
      letterSpacing: -1.w,
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.h6: TextStyle(
      fontSize: 16.sp,
      fontFamily: fontFamily,
      height: 1.5,
      letterSpacing: -0.3.w,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(26, 32, 44, 1),
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.h5: TextStyle(
      fontSize: 20.sp,
      fontFamily: fontFamily,
      height: 1.3,
      letterSpacing: -1.w,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(26, 32, 44, 1),
      fontFeatures: [
        FontFeature.tabularFigures(),
      ]),
  TextTypes.h4: TextStyle(
      fontSize: 24.sp,
      fontFamily: fontFamily,
      height: 1.4,
      letterSpacing: -1.w,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(26, 32, 44, 1),
      fontFeatures: [
        FontFeature.tabularFigures(),
      ])
};

class BaseText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight weightType;
  final Color textColor;
  final double letterSpacing;
  final TextAlign align;
  final double lineHeight;
  final double verticalPadding;
  final double horizontalPadding;
  final TextTypes type;
  final EdgeInsets padding;
  final TextOverflow overflow;
  final int maxLines;

  const BaseText(
      {Key key,
      this.text,
      this.fontSize,
      this.weightType,
      this.textColor,
      this.letterSpacing,
      this.align,
      this.lineHeight,
      this.verticalPadding = 0,
      this.horizontalPadding = 0,
      this.type = TextTypes.p1,
      this.padding,
      this.overflow, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding != null
            ? padding
            : EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: horizontalPadding),
        child: Text(
          text,
          textAlign: align != null ? align : TextAlign.left,
          overflow: overflow != null ? overflow : TextOverflow.clip,
          style: defaultTextStyles[type].copyWith(
            height: lineHeight,
            fontWeight: weightType,
            fontSize: fontSize,
            color: textColor,
            letterSpacing: letterSpacing,
          ),
          maxLines: maxLines,
        ));
  }
}
