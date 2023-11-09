import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/register/model.create.account.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/services/services.auth.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepFour.controller.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepOne.controller.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepTwo.controller.dart';

class RegisterScreenController extends GetxController {
  Map<String, RxMap<String, dynamic>> steps =
      RxMap<String, RxMap<String, dynamic>>({
    "step1": RxMap<String, dynamic>({
      "isActive": true,
      "isDone": false,
      "hasData": false,
      "label": 'Basic Information',
    }),
    "step2": RxMap<String, dynamic>({
      "isActive": false,
      "isDone": false,
      "hasData": false,
      "label": 'Investor Details',
    }),
  });

  RxBool isLoading = false.obs;

  RxInt currentPage = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  Color checkStepBase(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.primary;
    if (steps['step${step + 1}']!['isActive']!) return AppColor.primary;
    return AppColor.iconInactive;
  }

  Color checkDivider(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.primary;
    return AppColor.iconInactive;
  }

  Color checkStepInnerBase(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.primary;
    return AppColor.white;
  }

  Color checkSvgBase(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.white;
    if (steps['step${step + 1}']!['isActive']!) return AppColor.primary;
    return AppColor.iconInactive;
  }

  Color checkTextColor(int step) {
    bool isDone = steps['step${step + 1}']!['isDone']! &&
        steps['step${step + 1}']!['isActive']!;
    if (isDone) return AppColor.primary;
    if (steps['step${step + 1}']!['isActive']!) return AppColor.primary;
    return AppColor.greyLigth;
  }

  goBack() {
    HC.hideKeyBoard();
    if (currentPage.value == 0) {
      //cancel ongoing request to the server
      MyRequestClass.cancelAllConnection();
      // if (Get.previousRoute != AppRoutes.name(RouteName.welcome)) {
      //   return Get.offAllNamed();
      // }
      return Get.offAllNamed(AppRoutes.name(RouteName.login));
    }
    //setting the previous screen stepper is isActive to false
    steps['step${currentPage.value + 1}']!['isActive'] = false;
    //setting the previous screen stepper is isDone to false
    steps['step${currentPage.value}']!['isDone'] = false;
    currentPage.value -= 1;
    update();
  }

  next() {
    final data = Get.find<StepOneController>().fullName;

    HC.hideKeyBoard();
    if (currentPage.value + 1 == steps.length) {
      final data1 = Get.find<StepTwoController>().accountName;
      log('---- ${data1.text}');
      return Get.toNamed(AppRoutes.name(RouteName.createAccount));
    }
    //setting the current screen stepper is done to false
    steps['step${currentPage.value + 1}']!['isDone'] = true;
    // setting the next screen stepper to active
    steps['step${currentPage.value + 2}']!['isActive'] = true;
    currentPage.value += 1;
    update();
    log('${data!.text} ----');
  }

  submit() async {
    HC.hideKeyBoard();
    try {
      Get.find<StepFourController>().isLoading.value = true;
      update();
      if (Get.find<StepFourController>().confirmPassword!.text.trim() ==
          Get.find<StepFourController>().password!.text.trim()) {
        CreateAccountModel data = CreateAccountModel(
          // all step one
          fullName: Get.find<StepOneController>().fullName!.text,
          lga: Get.find<StepOneController>().selectedLga.value,
          state: Get.find<StepOneController>().selectedState.value,
          companyName: Get.find<StepOneController>().companyName!.text.trim(),
          phoneNumber: Get.find<StepOneController>().phoneNumber!.text,
          phoneNumber2: Get.find<StepOneController>().phoneNumber2!.text.isEmpty
              ? "null"
              : Get.find<StepOneController>().phoneNumber!.text,
          //all step two
          bankName: Get.find<StepTwoController>().selectedBank.value,
          ownVehicle: Get.find<StepTwoController>().ownVehicle.value,
          accountName: Get.find<StepTwoController>().accountName.text.trim(),
          accountNumber:
              Get.find<StepTwoController>().accountNumber.text.trim(),
          address: Get.find<StepTwoController>().fullAddress.text.trim(),
          financialCapacity:
              Get.find<StepTwoController>().financialCapacity.value,
          // all step four
          code: Get.find<StepFourController>()
              .code!
              .text
              .trim()
              .replaceAll('-', ''),
          email: Get.find<StepFourController>().email!.text.trim(),
          password: Get.find<StepFourController>().password!.text.trim(),
        );
        log(data.toJson().toString());
        final response = await Get.find<AuthService>().register(data);
        Get.find<StepFourController>().isLoading.value = false;
        update();
        if (response.success) {
          // await Config.clearImageUrls();
          final data = await AppStorage.readData(
              storageName: StorageNames.configStorage.name,
              key: StorageKeys.uploadUrls.name);
          log(data.toString());
          HC.snack(response.message, success: response.success);
          isLoading.value = false;
          return Get.offAllNamed(AppRoutes.name(RouteName.login));
        }
        HC.snack(response.message, success: response.success);
        return;
      }
      isLoading.value = false;
      return HC.snack("Password didn't match", success: false);
    } catch (e) {
      isLoading.value = false;
      return HC.snack("$e", success: false);
    }
  }

  @override
  void onClose() {
    Get.find<StepOneController>().dispose();
    Get.find<StepTwoController>().dispose();
    super.onClose();
  }
}

class RegisterScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
  }
}
