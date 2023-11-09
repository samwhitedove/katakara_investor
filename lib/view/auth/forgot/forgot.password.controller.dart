import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool canResend = false.obs;
  RxBool isPasswordVisible = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  bool canReset = false;
  bool hasValidEmail = false;

  bool hasNewPassword = false;
  void onChangeText() {}

  void validateEmail() {
    hasValidEmail = HC.validateEmail(email.text);
    update();
  }

  void checkPassword() {
    hasNewPassword = newPassword.text == confirmNewPassword.text &&
        HC.validatePasswordStrength(newPassword.text)['status'];
    update();
  }

  dynamic validateConfirmPassword() {
    final isGood = newPassword.text == confirmNewPassword.text;
    return isGood ? null : "Password didnot match";
  }

  void setNewPassword() async {
    isLoading.value = true;
    final RequestResponsModel data = await MyRequestClass.krequest(
        endPoint: EndPoint.resetUserPassword,
        method: Methods.post,
        body: {
          "code": otp.text.replaceAll("-", ''),
          "newPassword": newPassword.text,
          "email": email.text
        });

    if (data.success) {
      HC.snack(data.message, success: data.success);
      isLoading.value = false;
      return Get.offAllNamed(AppRoutes.name(RouteName.login));
    }
    isLoading.value = false;
    HC.snack(data.message);
  }

  requestCode() async {
    isLoading.value = true;
    final data = await MyRequestClass.krequest(
        endPoint: EndPoint.requestPasswordResetCode,
        method: Methods.post,
        body: {"email": email.text});
    otpTimer();
    isLoading.value = false;
    return data;
  }

  void confirmEmail() async {
    HC.hideKeyBoard();
    RequestResponsModel model = await requestCode();
    if (model.success) {
      HC.snack(model.message, success: model.success);
      return Get.toNamed(AppRoutes.name(RouteName.setNewPassword));
    }
    HC.snack(model.message);
  }

  RxInt start = 60.obs;
  Timer? timer;
  void otpTimer() {
    canResend.value = false;
    timer = Timer.periodic(CW.onesSec, (timer) {
      if (start.value == 1) {
        timer.cancel();
        start.value = 60;
        canResend.value = true;
      }
      start.value -= 1;
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
