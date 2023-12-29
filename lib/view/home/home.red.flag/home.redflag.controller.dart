import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class RegFlagController extends GetxController {
  TextEditingController subject = TextEditingController();
  TextEditingController summary = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool hasValidValue = false.obs;

  void changedValue() {
    hasValidValue.value = subject.text.length > 4 && summary.text.length > 10;
    update();
  }

  void submit() async {
    HC.hideKeyBoard();
    if (hasValidValue.value) {
      isLoading.value = true;
      update();
      RequestResponseModel response = await MyRequestClass.krequest(
          endPoint: EndPoint.createRedFlag,
          body: {
            "title": "Red flag",
            "subject": subject.text,
            "message": summary.text
          },
          method: Methods.put);
      if (response.success) {
        isLoading.value = false;
        HC.snack(response.message, success: response.success);
        update();
        return;
      }
      HC.snack(response.message, success: response.success);
      isLoading.value = false;
      update();
    }
  }
}
