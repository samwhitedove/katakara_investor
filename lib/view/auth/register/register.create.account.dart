import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';

import 'register.dart';

class CreateAccountRegisterScreen extends StatelessWidget {
  CreateAccountRegisterScreen({super.key});

  final _ = Get.find<RegisterScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CW.baseStackWidget(
          isLoading: _.isLoading.value,
          children: [
            CW.form(
              size: 0,
              formKey: _.createAccountFormKey,
              children: [
                GetX<RegisterScreenController>(
                  init: _,
                  builder: (controller) => CW.baseWidget(
                    children: [
                      CW.AppSpacer(h: 40),
                      CW.backButton(onTap: Get.back),
                      CW.AppSpacer(h: 16),
                      const Text(tRegister).title(),
                      CW.AppSpacer(h: 8),
                      const Text(tCreateYourLogin).subTitle(),
                      CW.AppSpacer(h: 20.7),
                      CW.textField(
                          label: tEmailAddress,
                          controller: _.email!,
                          focus: _.emailFocus,
                          fieldName: tEmail,
                          readOnly: _.hasRequestVerifyEmail.value,
                          validate: true,
                          inputType: TextInputType.emailAddress,
                          onChangeValue: () => _.stepChecker('step4')),
                      CW.AppSpacer(h: 8),
                      Obx(
                        () => Visibility(
                          visible: _.hasRequestVerifyEmail.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible:
                                    _.canSendEmailVerificationRequest.value,
                                child: Text("Edit Email")
                                    .title(fontSize: 12)
                                    .toButton(onTap: _.editEmail),
                              ),
                              Builder(
                                builder: (context) {
                                  if (_.canSendEmailVerificationRequest.value &&
                                      !_.hasVerifiedEmail()) {
                                    return Text("Resend Code")
                                        .title(fontSize: 12)
                                        .toButton(
                                            onTap:
                                                _.requestEmailVerificationCode);
                                  }

                                  if (_.hasRequestVerifyEmail() &&
                                      !_.hasVerifiedEmail()) {
                                    return Obx(() => (Text(
                                            "You can edit Email or Resend Code in: ${_.time.value} sec")
                                        .subTitle(fontSize: 12)));
                                  }

                                  return SizedBox();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      CW.AppSpacer(h: 16),
                      Obx(
                        () => Visibility(
                          visible: _.hasRequestVerifyEmail.value &&
                              !_.hasVerifiedEmail.value,
                          child: Column(
                            children: [
                              CW.textField(
                                  label: tCode,
                                  fieldName: tCode.toLowerCase(),
                                  inputType: TextInputType.number,
                                  controller: _.code!,
                                  onChangeValue: _.validateOTP),
                              CW.button(
                                  onPress: _.hasInputCode.value
                                      ? _.verifyEmail
                                      : null,
                                  text: tVerifyEmail),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: !_.hasRequestVerifyEmail.value,
                          child: Column(
                            children: [
                              CW.button(
                                  onPress: _.hasValidEmail.value &&
                                          !_.hasRequestVerifyEmail.value
                                      ? _.requestEmailVerificationCode
                                      : null,
                                  text: tRequestCode),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: !_.hasVerifiedEmail.value,
                          child: Column(
                            children: [
                              CW.passwordField(
                                  label: tPassword,
                                  showText: _.isPasswordVisible.value,
                                  controller: _.password!,
                                  customValidation: _.checkPasswordStrenght,
                                  onHide: _.isPasswordVisible.toggle,
                                  validate: true,
                                  onChangeValue: () => _.stepChecker('step4')),
                              CW.AppSpacer(h: 16),
                              CW.passwordField(
                                  label: tConfirmPassword,
                                  showText: _.isPasswordVisible.value,
                                  controller: _.confirmPassword!,
                                  validate: true,
                                  onHide: _.isPasswordVisible.toggle,
                                  customValidation: _.checkMatchLoginPassword,
                                  onChangeValue: () => _.stepChecker('step4')),
                              CW.AppSpacer(h: 48),
                              CW.button(
                                  onPress: _.isValidCredentails.value
                                      ? _.submit
                                      : null,
                                  text: tSubmit),
                              CW.AppSpacer(h: 24),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
