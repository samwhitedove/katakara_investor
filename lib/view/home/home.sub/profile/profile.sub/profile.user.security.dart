import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/text.dart';
import 'package:katakara_investor/view/home/home.dart';

class UserSecurity extends StatelessWidget {
  const UserSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
        initState: (_) {},
        builder: (_) {
          return CW.baseStackWidget(
            isLoading: _.isSavingSecurity.value,
            side: 15,
            children: [
              CW.AppSpacer(h: 70),
              CW.backButton(onTap: Get.back),
              CW.AppSpacer(h: 30),
              const Text(tSecurity).title(),
              CW.AppSpacer(h: 10),
              const Text(tChangePassword).subTitle(),
              CW.AppSpacer(h: 20),
              CW.textField(
                  label: tOlPassword,
                  controller: _.oldPassword,
                  onChangeValue: () {}),
              CW.AppSpacer(h: 10),
              CW.form(
                size: 0,
                formKey: const ValueKey("changenewpasswordkey"),
                children: [
                  Obx(() => CW.passwordField(
                      onHide: _.showPassword.toggle,
                      showText: _.showPassword.value,
                      label: tNewPassword,
                      controller: _.newPassword,
                      validate: true,
                      customValidation: () => HC.validatePasswordStrength(
                          _.newPassword.text.trim())['message'],
                      onChangeValue: _.checkPasswordIsValidToSave)),
                  CW.AppSpacer(h: 10),
                  Obx(() => CW.passwordField(
                        onHide: _.showPassword.toggle,
                        showText: _.showPassword.value,
                        label: tConfirmPassword,
                        validate: true,
                        customValidation: _.checkPassword,
                        controller: _.confirmPassword,
                        onChangeValue: _.checkPasswordIsValidToSave,
                      )),
                  CW.AppSpacer(h: 30),
                  Obx(() => CW.button(
                      onPress:
                          _.canUpdatePassword.value ? _.savePassword : null,
                      text: tSave))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
