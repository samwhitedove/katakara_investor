import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';

import 'youtube.link.controller.dart';

class SetYoutubeUrlScreen extends StatelessWidget {
  const SetYoutubeUrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetYoutubeUrlController>(
      init: SetYoutubeUrlController(),
      initState: (_) {},
      builder: (_) {
        return CW.pageWithAppBar(title: tAddYou, children: [
          CW.AppSpacer(h: 30),
          const Text(tAddYoutube).title(),
          CW.AppSpacer(h: 10),
          const Text(tAddYoutube).subTitle(),
          CW.AppSpacer(h: 20),
          CW.AppSpacer(h: 30),
          CW.textField(
            lines: 1,
            label: tLink,
            controller: _.link!,
            hint: tLinkExample,
            onChangeValue: _.checkFields,
          ),
          CW.AppSpacer(h: 40),
          CW.button(
              onPress: _.isGoodInput ? _.save : null,
              text: tSave,
              isLoading: _.isLoading)
        ]);
      },
    );
  }
}
