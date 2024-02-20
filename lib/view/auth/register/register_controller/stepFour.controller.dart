import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.auth.dart';

class StepFourController extends GetxController {
  TextEditingController? email;
  TextEditingController? password;
  TextEditingController? confirmPassword;
  TextEditingController? code;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    code = TextEditingController();
    super.onInit();
  }

  @override
  onClose() {
    _timer?.cancel();
    email?.dispose();
    password?.dispose();
    confirmPassword?.dispose();
    code?.dispose();
    super.onClose();
  }

  RxBool hasValidEmail = false.obs;
  RxBool isValidCredentails = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool hasRequestEmailVerification = false.obs;
  RxBool canSendEmailVerificationRequest = false.obs;
  RxBool hasVerifiedEmail = false.obs;

  RxBool hasInputCode = false.obs;
  RxBool isLoading = false.obs;

  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  RxInt time = 60.obs;
  Timer? _timer;

  startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (time.value != 1) {
        time.value -= 1;
        return;
      }

      time.value -= 1;
      _timer!.cancel();
      canSendEmailVerificationRequest.value = true;
      time.value = 60;
    });
  }

  verifyEmail() async {
    HC.hideKeyBoard();
    isLoading.value = true;
    RequestResponseModel response = await Get.find<AuthService>().verifyEmail({
      "email": Get.find<StepFourController>().email!.text,
      "code": Get.find<StepFourController>().code!.text.replaceAll('-', '')
    });
    if (response.success) {
      hasVerifiedEmail.value = true;
      canSendEmailVerificationRequest.value = true;
      isLoading.value = false;
      return HC.snack(response.message, success: response.success);
    }
    isLoading.value = false;
    return HC.snack(response.message, success: response.success);
  }

  editEmail() {
    hasRequestEmailVerification.value = false;
    hasVerifiedEmail.value = false;
    _timer!.cancel();
  }

  validateOTP() {
    return hasInputCode.value = code!.text.length == 7;
  }

  dynamic checkPasswordStrenght() {
    return HC.validatePasswordStrength(password!.text.trim())['message'];
  }

  void requestEmailVerificationCode() async {
    HC.hideKeyBoard();
    isLoading.value = true;
    RequestResponseModel response = await Get.find<AuthService>()
        .requestEmailCode(
            {"email": Get.find<StepFourController>().email!.text});
    if (response.success) {
      hasRequestEmailVerification(true);
      canSendEmailVerificationRequest(false);
      startTimer();
      isLoading.value = false;
      HC.snack(response.message, success: true);
      return;
    }
    isLoading.value = false;
    HC.snack(response.message);
  }

  dynamic checkMatchLoginPassword() {
    if (confirmPassword!.text.isEmpty) {
      return null;
    }

    if (confirmPassword!.text == password!.text) {
      return null;
    }
    return "Password didn't match.";
  }

  void stepFourChecker() {
    bool isGood = true;
    hasValidEmail.value = HC.validateEmail(email!.text);
    if (email!.text.trim().isEmpty) isGood = false;
    if (confirmPassword!.text.trim() != password!.text.trim()) isGood = false;
    if (password!.text.trim().isEmpty) isGood = false;
    isValidCredentails.value = isGood;
  }
}

class StepFourBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StepFourController>(() => StepFourController());
  }
}
