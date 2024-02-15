import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/values/colors.dart';

BottomSheetModal(Widget child, {Color? color}) {
  return Get.bottomSheet(
    child,
    backgroundColor: color ?? AppColor.white,
    clipBehavior: Clip.none,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}
