import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/red_flag/admin.redflag.controller.dart';

class RedFlagDetails extends StatelessWidget {
  const RedFlagDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RedFlagController>(
      init: RedFlagController(),
      initState: (_) {},
      builder: (_) {
        return Stack(
          children: [
            CW.pageWithAppBar(
              others: const CircleAvatar(
                backgroundColor: AppColor.red,
                child: Icon(
                  Icons.delete,
                  color: AppColor.white,
                ),
              ).toButton(onTap: _.handleDelete),
              title: tRedFlag,
              children: [
                CW.AppSpacer(h: 30),
                DisplayData("Title", _.selectedData!.title.toString().trim()),
                DisplayData(
                    "Subject", _.selectedData!.subject.toString().trim()),
                DisplayData(
                    "Message", _.selectedData!.message.toString().trim()),
              ],
            ),
            CW.LoadingOverlay(_.isLoading),
          ],
        );
      },
    );
  }

  Padding DisplayData(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(title).title(fontSize: 14),
          ),
          Text(subTitle)
        ],
      ),
    );
  }
}
