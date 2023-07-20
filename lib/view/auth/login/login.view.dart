import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';

import 'login.controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LoginScreenController>(
      init: LoginScreenController(),
      initState: (_) {},
      builder: (_) {
        return Obx(
          () => CW.baseStackWidget(
            isLoading: _.isLoading.value,
            children: [
              CW.form(
                formKey: _.loginFormKey,
                children: [
                  CW.AppSpacer(h: 127),
                  const Text(tSignInToAccount).title(),
                  const Text(tEnterDetails).subTitle(),
                  CW.AppSpacer(h: 48),
                  CW.textField(
                      label: tEmailAddress,
                      controller: _.email,
                      fieldName: tEmail,
                      validate: true,
                      onChangeValue: _.onChange),
                  CW.AppSpacer(h: 16),
                  CW.passwordField(
                      label: tPassword,
                      showText: _.isPasswordVisible.value,
                      controller: _.pass,
                      onHide: _.isPasswordVisible.toggle,
                      onChangeValue: _.onChange),
                  CW.AppSpacer(h: 8),
                  const Text(tForgetPasswordQ).textButton(
                      onTap: () => Get.toNamed(
                          AppRoutes.name(RouteName.forgotPassword))),
                  CW.AppSpacer(h: 48),
                  Obx(() => CW.button(
                      onPress: _.canLogin.value ? _.login : null,
                      text: tSignIn)),
                  CW.AppSpacer(h: 24),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: tDontHaveAccount).label(),
                        const TextSpan(text: tRegister)
                            .title(color: AppColor.primary, fontSize: 14),
                      ],
                    ),
                  ).align(Al.center).toButton(
                        onTap: () => Get.toNamed(
                          AppRoutes.name(RouteName.register),
                        ),
                      ),
                ],
              ),
            ],
          ),
        );
      },
    ));
  }
}
