import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';

import 'forgot.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (_) {
        return Obx(
          () => CW.baseStackWidget(
            isLoading: _.isLoading.value,
            side: 15,
            children: [
              CW.AppSpacer(h: 79),
              CW.backButton(),
              CW.AppSpacer(h: 10),
              const Text(tForgetPassword).title(),
              CW.AppSpacer(h: 8),
              FittedBox(
                child: const Text(eEnterEmailAssociate).subTitle(),
              ),
              CW.AppSpacer(h: 48),
              CW.form(
                size: 0,
                formKey: ValueKey('resetemailform'),
                children: [
                  CW.textField(
                      label: tEmailAddress,
                      fieldName: tEmail,
                      controller: _.email,
                      validate: true,
                      onChangeValue: _.validateEmail),
                ],
              ),
              CW.AppSpacer(h: 48),
              CW.button(
                  onPress: _.hasValidEmail ? _.confirmEmail : null,
                  text: tResetPassword)
            ],
          ),
        );
      },
    ));
  }
}
