import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';

// ignore: must_be_immutable
class NoDataFound extends StatelessWidget {
  Widget? icon;
  String? text;
  NoDataFound({super.key, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ??
              Icon(
                Icons.event_note_outlined,
                size: 40,
                color: AppColor.greyLigth,
              ),
          Text(text ?? "No Faq Found")
              .subTitle(color: AppColor.grey, fontSize: 14)
              .paddingOnly(top: 10)
        ],
      ),
    );
  }
}
