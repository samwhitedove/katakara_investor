import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.auth.dart';
import 'package:katakara_investor/values/values.dart';

class LoginScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool canLogin = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool onChange() {
    if (email.text.isNotEmpty &&
        pass.text.isNotEmpty &&
        HC.validateEmail(email.text)) {
      return canLogin(true);
    }
    return canLogin(false);
  }

  void hide() {}

  void login() async {
    HC.hideKeyBoard();
    isLoading.value = true;
    RequestResponsModel response = await Get.find<AuthService>()
        .login({'email': email.text.trim(), "password": pass.text.trim()});
    isLoading.value = false;
    if (response.success) {
      log("data -------------21");
      AppStorage.saveData(
        storageName: StorageNames.settingsStorage.name,
        key: SettingsKey.isLogin.name,
        value: true,
      );
      log("data -------------21");
      HC.snack(response.message, success: response.success);
      log("data -------------22");
      Get.offAllNamed(AppRoutes.name(RouteName.home));
      return;
    }
    log("data -------------1");
    HC.snack(response.message, success: response.success);
    isLoading.value = false;
  }
}
