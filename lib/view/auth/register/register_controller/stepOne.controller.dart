import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/auth/auth.dart';

class StepOneController extends GetxController {
  RxBool isUploading = false.obs;
  RxBool isCompleted = false.obs;
  RxBool isActive = false.obs;

  RxString state = "".obs;
  RxString city = "".obs;
  RxString profileImageUrl = "".obs;
  TextEditingController? fullName;
  TextEditingController? companyName;
  TextEditingController? phoneNumber;
  TextEditingController? phoneNumber2;

  @override
  void onClose() {
    fullName?.dispose();
    companyName?.dispose();
    phoneNumber?.dispose();
    phoneNumber2?.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    fullName = TextEditingController();
    companyName = TextEditingController();
    phoneNumber = TextEditingController();
    phoneNumber2 = TextEditingController();
    fullName?.addListener(() => stepOneChecker());
    companyName?.addListener(() => stepOneChecker());
    phoneNumber?.addListener(() => stepOneChecker());
    phoneNumber2?.addListener(() => stepOneChecker());
    super.onInit();
  }

  RxString selectedState = stateAndLga.keys.first.obs;
  RxString selectedLga = stateAndLga.values.first.first.obs;

  void stepOneChecker() {
    bool isGood = true;
    if (fullName!.text.trim().isEmpty) isGood = false;
    if (companyName!.text.trim().isEmpty) isGood = false;
    if (phoneNumber!.text.trim().length != 11) isGood = false;
    if (selectedState.value == stateAndLga.keys.first) isGood = false;
    Get.find<RegisterScreenController>().steps['step1']!['hasData'] = isGood;
    update();
  }

  setState(String text) {
    selectedLga.value = text;
    stepOneChecker();
    update();
  }

  setLga(String text) {
    selectedState.value = text;
    selectedLga.value = stateAndLga[text]!.first;
    stepOneChecker();
    update();
  }
}

class StepOneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StepOneController>(() => StepOneController());
  }
}
