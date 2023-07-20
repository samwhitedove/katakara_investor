import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FaqController>(
        init: FaqController(),
        initState: (_) {},
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CW.AppSpacer(h: 70),
            CW.backButton(onTap: Get.back),
            CW.AppSpacer(h: 20),
            Text(tFaqQuestion).title(),
            CW.AppSpacer(h: _.isLoading ? 20 : 0),
            _.isLoading
                ? LinearProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _.data.length,
                      itemBuilder: (context, index) => Container(
                        color: AppColor.primaryLight,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: Get.width * .83,
                                      minWidth: Get.width * .81),
                                  child: Text(_.data[index]['question'])
                                      .title(fontSize: 12)
                                      .paddingSymmetric(
                                        horizontal: 4,
                                        vertical: 4,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    _.data[index]['isView']
                                        ? Icons.keyboard_arrow_up_outlined
                                        : Icons.keyboard_arrow_down_outlined,
                                    color: AppColor.inActiveBlack,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Visibility(
                              visible: _.data[index]['isView'],
                              child: Text(_.data[index]['answer'])
                                  .subTitle()
                                  .paddingAll(4)
                                  .align(Al.left),
                            )
                          ],
                        ),
                      )
                          .toButton(
                              onTap: () => _.updateIsView(
                                  index, _.data[index]['isView']))
                          .marginOnly(bottom: 10),
                    ),
                  )
          ],
        ).addPaddingHorizontal(size: 15),
      ),
    );
  }
}
