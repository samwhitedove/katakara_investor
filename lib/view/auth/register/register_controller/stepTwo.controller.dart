import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/auth/auth.dart';

class StepTwoController extends GetxController {
  // STEP TWO VARIABLES
  RxString selectedBank = banks.first.obs;
  RxString ownVehicle = yesVehicle.first.obs;
  RxString financialCapacity = finance.first.obs;

  TextEditingController accountName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController fullAddress = TextEditingController();

  @override
  void onInit() {
    accountName.addListener(() => stepTwoChecker());
    accountNumber.addListener(() => stepTwoChecker());
    super.onInit();
  }

  void setBankName(String text) {
    selectedBank.value = text;
    stepTwoChecker();
    update();
  }

  void setCapital(String text) {
    ownVehicle.value = text;
    stepTwoChecker();
    update();
  }

  void stepTwoChecker() {
    bool isGood = true;
    if (accountName.text.trim().isEmpty) isGood = false;
    if (accountNumber.text.trim().length != 10) isGood = false;
    if (selectedBank.value == banks.first) isGood = false;
    Get.find<RegisterScreenController>().steps['step2']!['hasData'] = isGood;
  }
}

class StepTwoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StepTwoController>(() => StepTwoController());
  }
}
