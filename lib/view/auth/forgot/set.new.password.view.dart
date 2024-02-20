// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/values/values.dart';

import 'forgot.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<ForgotPasswordController>(
      builder: (_) {
        return Obx(
          () => CW.baseWidget(
            isLoading: _.isLoading.value,
            children: [
              CW.AppSpacer(h: 69),
              CW.backButton(),
              CW.AppSpacer(h: 20),
              const Text(tNewPassword).title(),
              CW.AppSpacer(h: 8),
              FittedBox(
                child: const Text(tEnterOtpReceived).subTitle(),
              ),
              CW.form(
                size: 0,
                formKey: ValueKey("newPasswordKey"),
                children: [
                  CW.AppSpacer(h: 48),
                  CW.textField(
                    label: tOtpCOde,
                    validate: true,
                    fontSize: 20,
                    fieldName: tCode.toLowerCase(),
                    controller: _.otp,
                    onChangeValue: _.onChangeText,
                  ),
                  CW.AppSpacer(h: 16),
                  Obx(() => CW.passwordField(
                      label: tNewPassword,
                      showText: _.isPasswordVisible.value,
                      controller: _.newPassword,
                      customValidation: () => HC.validatePasswordStrength(
                          _.newPassword.text.trim())['message'],
                      onHide: _.isPasswordVisible.toggle,
                      validate: true,
                      onChangeValue: _.checkPassword)),
                  CW.AppSpacer(h: 16),
                  Obx(() => CW.passwordField(
                      label: tConfirmPassword,
                      showText: _.isPasswordVisible.value,
                      controller: _.confirmNewPassword,
                      customValidation: _.validateConfirmPassword,
                      onHide: _.isPasswordVisible.toggle,
                      validate: true,
                      onChangeValue: _.checkPassword)),
                ],
              ),
              CW.AppSpacer(h: 38),
              Obx(() => Text(
                      "$tResendOtp ${_.canResend.value ? tResend : '${_.start}$tSec'}")
                  .textButton(
                      onTap: _.requestCode,
                      color:
                          _.canResend.value ? AppColor.primary : AppColor.grey)
                  .align(Al.center)),
              CW.AppSpacer(h: 38),
              CW.button(
                  onPress: _.hasNewPassword ? _.setNewPassword : null,
                  text: tResetPassword)
            ],
          ),
        );
      },
    ));
  }
}
