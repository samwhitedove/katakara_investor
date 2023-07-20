import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../values/values.dart';

extension ExtendWidget on Widget {
  Padding addPaddingVertical({double size = 20}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size),
      child: this,
    );
  }

  Padding addPaddingHorizontal({double size = 20}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size),
      child: this,
    );
  }

  Align align(Al align) {
    return Align(
      alignment: align == Al.center
          ? Alignment.center
          : align == Al.right
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: this,
    );
  }

  GestureDetector toButton({Function()? onTap}) {
    return GestureDetector(onTap: onTap, child: this);
  }

  InkWell toElevatedButton({Function()? onTap, BorderRadius? radius}) {
    return InkWell(
      borderRadius: radius,
      onTap: onTap,
      child: Ink(child: this),
    );
  }

  Container halfWidth(
      {bool marginRight = false, double? width, double margin = 4}) {
    return Container(
      width: Get.width * (width ?? .45),
      margin: EdgeInsets.only(right: marginRight ? margin : 0),
      child: this,
    );
  }

  toObx() {
    return Obx(() => this);
  }

  Container roundCorner({
    Color bgColor = Colors.white,
    Color borderColor = Colors.grey,
    double? radius,
    double topLeftRadius = 8,
    double bottomLeftRadius = 8,
    double topRightRadius = 8,
    double bottomRightRadius = 8,
    double elevation = 0,
    Offset offSet = const Offset(0, 0),
    double blurRadius = 0,
    EdgeInsets padding = EdgeInsets.zero,
    EdgeInsets margin = EdgeInsets.zero,
    BlurStyle blurStyle = BlurStyle.normal,
    double? width,
    bool showBorder = true,
    double height = 50,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(
            color: !showBorder ? AppColor.transparent : borderColor,
            style: BorderStyle.solid,
            width: !showBorder ? 0 : 2),
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.grey,
            blurRadius: blurRadius,
            blurStyle: blurStyle,
            spreadRadius: elevation,
            offset: offSet,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius ?? bottomLeftRadius),
          topLeft: Radius.circular(radius ?? topLeftRadius),
          bottomRight: Radius.circular(radius ?? bottomRightRadius),
          topRight: Radius.circular(radius ?? topRightRadius),
        ),
      ),
      child: this,
    );
  }
}
