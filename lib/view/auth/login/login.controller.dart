import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

import '../../../models/register/register.dart';

class LoginScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool canLogin = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

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
    RequestResponsModel responsModel = await MyRequestClass.krequest(
        endPoint: EndPoint.login,
        method: Methods.post,
        body: {'email': email.text.trim(), "password": pass.text.trim()});

    if (responsModel.success) {
      userData = UserDataModel.fromJson(responsModel.data);
      AppSettings.saveUserToLocal(userData.toJson());
      AppStorage.saveData(
        storageName: StorageNames.settings.name,
        key: SettingsKey.isLogin.name,
        value: true,
      );
      Get.offAllNamed(AppRoutes.name(RouteName.home));
      isLoading.value = false;
      return;
    }

    HC.snack(responsModel.message, success: responsModel.success);
    isLoading.value = false;
  }
}
