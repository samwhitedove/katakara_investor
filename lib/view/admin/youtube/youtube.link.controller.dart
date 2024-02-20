import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/services.home.dart';
import 'package:katakara_investor/view/home/home.dart';

class SetYoutubeUrlController extends GetxController {
  bool isLoading = false;
  bool isDeleting = false;
  bool isUpdating = false;
  bool isGoodInput = false;
  final AdminService adminService = Get.find<AdminService>();
  final HomeScreenController homeService = Get.find<HomeScreenController>();

  TextEditingController? link;

  @override
  void onInit() {
    link = TextEditingController(text: homeService.youtubeLink);
    super.onInit();
  }

  checkFields() {
    if (link!.text.trim().isNotEmpty && link!.text.startsWith("https://")) {
      isGoodInput = true;
      update();
      return;
    }
    isGoodInput = false;
    update();
    return false;
  }

  save() async {
    HC.hideKeyBoard();
    isLoading = true;
    update();
    final RequestResponseModel faq =
        await adminService.saveYoutubeLink({'link': link!.text});
    homeService.youtubeLink =
        (await Get.find<HomeService>().fetchYoutube()).data.first['link'];
    HC.snack(faq.message, success: faq.success);
    isLoading = false;
    update();
    return;
  }
}
