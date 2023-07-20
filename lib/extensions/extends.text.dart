import 'package:flutter/material.dart';
import 'package:katakara_investor/values/values.dart';

extension ExtendString on Text {
  Text title({Color? color, double? fontSize = 24}) {
    return Text(
      data!,
      softWrap: true,
      textScaleFactor: 1,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: color ?? AppColor.primary,
      ),
    );
  }

  Text subTitle({Color? color, double? fontSize = 12}) {
    return Text(
      data!,
      softWrap: true,
      textScaleFactor: 1,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? AppColor.subTitle,
      ),
    );
  }

  Text label({Color? color, double fontSize = 12}) {
    return Text(
      data!,
      softWrap: true,
      textScaleFactor: 1,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? AppColor.subTitle,
      ),
    );
  }

  GestureDetector textButton({Color? color, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        data!,
        softWrap: true,
        textScaleFactor: 1,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: color ?? AppColor.primary,
        ),
      ),
    );
  }

  GestureDetector toButton({Function()? onTap}) {
    return GestureDetector(onTap: onTap, child: this);
  }
}

extension RichSomeText on TextSpan {
  TextSpan title({Color? color, double? fontSize = 24}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: color ?? AppColor.primary,
      ),
    );
  }

  TextSpan subTitle({Color? color, double? fontSize = 12}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? AppColor.subTitle,
      ),
    );
  }

  TextSpan label({Color? color}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColor.subTitle,
      ),
    );
  }

  GestureDetector toButton({Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: this,
      ),
    );
  }
}
