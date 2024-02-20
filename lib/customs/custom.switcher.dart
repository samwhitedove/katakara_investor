import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';

// ignore: must_be_immutable
class CustomSwitcher extends StatelessWidget {
  bool? value;
  double? width;
  double? height;
  Color? bgColor;
  Color? fgColor;
  Function() onChange;

  CustomSwitcher(
      {super.key,
      required this.value,
      this.width,
      this.height,
      this.bgColor,
      required this.onChange,
      this.fgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(),
      child: Stack(
        children: [
          Container(
            width: Get.width * (width ?? .2), //22
            height: height ?? 30,
            decoration: BoxDecoration(
              color: fgColor ?? AppColor.grey,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: const Text(tGoLive)
                    .title(
                      color: AppColor.white,
                      fontSize: 12,
                    )
                    .paddingOnly(right: 3),
              ),
            ),
          ),
          AnimatedContainer(
            duration: CW.halfSec,
            width: Get.width * (value! ? width ?? .200 : .070), //.218 : .076),
            height: height ?? 30,
            decoration: BoxDecoration(
                color: bgColor ?? (value! ? AppColor.primary : AppColor.grey),
                borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: height ?? 26,
              width: height ?? 26,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ).align(Al.right),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(value! ? tLive : tEmpty).title(
                  color: AppColor.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
