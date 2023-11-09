import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepFour.controller.dart';
import 'package:katakara_investor/view/view.dart';

class CreateAccountRegisterScreen extends StatelessWidget {
  const CreateAccountRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepFourController>(
      init: StepFourController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: Obx(
            () => CW.baseStackWidget(
              isLoading: _.isLoading.value,
              children: [
                CW.form(
                  size: 0,
                  formKey: const ValueKey('stepFourForm'),
                  children: [
                    CW.baseWidget(
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
                          readOnly: _.hasRequestEmailVerification.value,
                          validate: true,
                          inputType: TextInputType.emailAddress,
                          onChangeValue: () => _.stepFourChecker(),
                        ),
                        CW.AppSpacer(h: 8),
                        Obx(
                          () => Visibility(
                            visible: _.hasRequestEmailVerification.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible:
                                      _.canSendEmailVerificationRequest.value,
                                  child: const Text("Edit Email")
                                      .title(fontSize: 12)
                                      .toButton(onTap: _.editEmail),
                                ),
                                Builder(
                                  builder: (context) {
                                    if (_.canSendEmailVerificationRequest
                                            .value &&
                                        !_.hasVerifiedEmail()) {
                                      return const Text("Resend Code")
                                          .title(fontSize: 12)
                                          .toButton(
                                              onTap: _
                                                  .requestEmailVerificationCode);
                                    }

                                    if (_.hasRequestEmailVerification() &&
                                        !_.hasVerifiedEmail()) {
                                      return Obx(() => (Text(
                                              "You can edit Email or Resend Code in: ${_.time.value} sec")
                                          .subTitle(fontSize: 12)));
                                    }

                                    return const SizedBox();
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        CW.AppSpacer(h: 16),
                        Obx(
                          () => Visibility(
                            visible: _.hasRequestEmailVerification.value &&
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
                            visible: !_.hasRequestEmailVerification.value,
                            child: Column(
                              children: [
                                CW.button(
                                    onPress: _.hasValidEmail.value &&
                                            !_.hasRequestEmailVerification.value
                                        ? _.requestEmailVerificationCode
                                        : null,
                                    text: tRequestCode),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                            visible: _.hasVerifiedEmail.value,
                            child: Column(
                              children: [
                                CW.passwordField(
                                  label: tPassword,
                                  showText: _.isPasswordVisible.value,
                                  controller: _.password!,
                                  customValidation: _.checkPasswordStrenght,
                                  onHide: _.isPasswordVisible.toggle,
                                  validate: true,
                                  onChangeValue: () => _.stepFourChecker(),
                                ),
                                CW.AppSpacer(h: 16),
                                CW.passwordField(
                                  label: tConfirmPassword,
                                  showText: _.isConfirmPasswordVisible.value,
                                  controller: _.confirmPassword!,
                                  validate: true,
                                  onHide: _.isConfirmPasswordVisible.toggle,
                                  customValidation: _.checkMatchLoginPassword,
                                  onChangeValue: () => _.stepFourChecker(),
                                ),
                                CW.AppSpacer(h: 48),
                                CW.button(
                                    onPress: _.isValidCredentails.value
                                        ? Get.find<RegisterScreenController>()
                                            .submit
                                        : null,
                                    text: tSubmit),
                                CW.AppSpacer(h: 24),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
