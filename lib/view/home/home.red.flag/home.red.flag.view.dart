import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/text.dart';
import 'package:katakara_investor/view/home/home.dart';

class RedFlagScreen extends StatelessWidget {
  const RedFlagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegFlagController>(
      init: RegFlagController(),
      initState: (_) {},
      builder: (_) {
        return CW.baseStackWidget(
          isLoading: _.isLoading.value,
          side: 20,
          children: [
            SizedBox(
              height: Get.height * .97,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CW.AppSpacer(h: 60),
                      CW.backButton(),
                      CW.AppSpacer(h: 20),
                      Text(tRedFlag).title(),
                      CW.AppSpacer(h: 5),
                      Text(tReport).subTitle(),
                      CW.AppSpacer(h: 30),
                      CW.textField(
                        label: tSubject,
                        controller: _.subject,
                        onChangeValue: _.changedValue,
                      ),
                      CW.AppSpacer(h: 16),
                      CW.textField(
                        label: tSummary,
                        controller: _.summary,
                        onChangeValue: _.changedValue,
                        lines: 8,
                        maxLength: 700,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CW.button(
                        onPress: _.hasValidValue.value ? _.submit : null,
                        text: tSubmit,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
