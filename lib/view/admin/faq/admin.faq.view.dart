import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';

import 'admin.faq.controller.dart';

class AddFAQScreen extends StatelessWidget {
  const AddFAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFaqController>(
      init: AddFaqController(),
      initState: (_) {},
      builder: (_) {
        return CW.pageWithAppBar(title: tNewFaq, children: [
          CW.AppSpacer(h: 30),
          const Text(tFaq).title(),
          CW.AppSpacer(h: 10),
          const Text(tAddFaq).subTitle(),
          CW.AppSpacer(h: 20),
          CW.textField(
            label: tQuestion,
            lines: 5,
            controller: _.question,
            onChangeValue: _.checkFields,
          ),
          CW.AppSpacer(h: 30),
          CW.textField(
            lines: 5,
            label: tAnswewr,
            controller: _.answer,
            onChangeValue: _.checkFields,
          ),
          CW.AppSpacer(h: 40),
          Column(
            children: [
              Visibility(
                visible: _.args == null,
                child: CW.button(
                    onPress: _.isGoodInput ? _.save : null,
                    text: tSave,
                    isLoading: _.isLoading),
              ),
              Visibility(
                visible: _.args != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CW
                        .button(
                            onPress:
                                _.isGoodInput && !(_.isUpdating || _.isDeleting)
                                    ? _.handleDelete
                                    : null,
                            text: tSave,
                            child: const Text(tDelete)
                                .subTitle(color: AppColor.white, fontSize: 12),
                            color: _.isUpdating || _.isDeleting
                                ? AppColor.greyLigth
                                : AppColor.red,
                            isLoading: _.isDeleting)
                        .halfWidth(width: .4),
                    CW
                        .button(
                            onPress:
                                _.isGoodInput && !(_.isUpdating || _.isDeleting)
                                    ? _.updateFaq
                                    : null,
                            color: _.isUpdating || _.isDeleting
                                ? AppColor.greyLigth
                                : AppColor.primary,
                            text: tSave,
                            child: const Text(tUpdate)
                                .title(color: AppColor.white, fontSize: 12),
                            isLoading: _.isUpdating)
                        .halfWidth(width: .4),
                  ],
                ),
              ),
            ],
          )
        ]);
      },
    );
  }
}
