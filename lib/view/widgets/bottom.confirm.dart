import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/extensions/extends.text.dart';
import 'package:katakara_investor/extensions/extends.widget.dart';

import '../../customs/custom.widget.dart';
import '../../values/colors.dart';
import '../../values/text.dart';

bottomConfirm(Function() onConfirm, {String? title}) {
  return Get.bottomSheet(
    SizedBox(
      // height: Get.height * .15,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title ?? "Confirm")
              .title(fontSize: 14, color: AppColor.text)
              .addPaddingVertical(size: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CW
                  .button(
                      onPress: () {
                        Get.back();
                        onConfirm.call();
                      },
                      text: tYes)
                  .halfWidth(width: .4)
                  .paddingOnly(right: 10),
              CW
                  .button(onPress: Get.back, text: tNo, color: AppColor.red)
                  .halfWidth(width: .4)
            ],
          ),
        ],
      ),
    ),
    backgroundColor: AppColor.white,
    clipBehavior: Clip.none,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}
