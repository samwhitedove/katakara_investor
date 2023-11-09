// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:katakara_investor/values/values.dart';
// import 'package:katakara_investor/view/auth/auth.dart';

// class StepThreeController extends GetxController {
//   TextEditingController fullAddress = TextEditingController();
//   RxString selectedId = governmentIds.first.obs;
//   RxString cacImageUrl = ''.obs;
//   RxString govermentImageUrl = ''.obs;
//   RxString letterHeadUrl = ''.obs;
//   final controller = Get.find<RegisterScreenController>();

//   bool stepThreeChecker() {
//     if (fullAddress.text.isEmpty) return false;
//     if (selectedId.value != governmentIds.first) return false;
//     if (govermentImageUrl.value.isEmpty) return false;
//     return controller.steps['step3']!['hasData'] = true;
//   }
// }

// class StepOneBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<StepThreeController>(() => StepThreeController());
//   }
// }
