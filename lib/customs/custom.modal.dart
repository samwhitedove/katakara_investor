import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extends.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';

Future<dynamic> warningModal(
    {required Function()? onSubmit, Function()? onCancel}) {
  return Get.bottomSheet(
    Container(
      height: HC.spaceVertical(100),
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CW
                .button(
                    onPress: () {
                      Get.back();
                      onSubmit?.call();
                    },
                    text: "Yes",
                    color: AppColor.red)
                .halfWidth(),
            CW
                .button(
                  onPress: onCancel?.call ?? Get.back,
                  text: "Cancel",
                )
                .halfWidth()
          ],
        ),
      ),
    ),
  );
}
