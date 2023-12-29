import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/services.home.dart';

import '../../widgets/bottom.confirm.dart';

class AddFaqController extends GetxController {
  bool isLoading = false;
  bool isGoodInput = false;
  final AdminService adminService = Get.find<AdminService>();
  final HomeService homeService = Get.find<HomeService>();

  int? id;

  final args = Get.arguments;

  TextEditingController question = TextEditingController();
  TextEditingController answer = TextEditingController();

  @override
  void onInit() {
    if (args != null) {
      question.text = args['question'];
      answer.text = args['answer'];
      isGoodInput = true;
    }
    super.onInit();
  }

  loadFaq() async {
    isLoading = true;
    update();
    await homeService.fetchFaq();
    isLoading = false;
    update();
    return;
  }

  checkFields() {
    if (answer.text.trim().isNotEmpty && question.text.trim().isNotEmpty) {
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
    final RequestResponseModel faq = await adminService
        .saveFaq({'question': question.text, 'answer': answer.text});
    HC.snack(faq.message, success: faq.success);
    question.clear();
    answer.clear();
    await loadFaq();
    isLoading = false;
    update();
    return;
  }

  updateFaq() async {
    HC.hideKeyBoard();
    isLoading = true;
    update();
    final RequestResponseModel faq = await adminService
        .saveFaq({'question': question.text, 'answer': answer.text, "id": id});
    HC.snack(faq.message, success: faq.success);
    await loadFaq();
    isLoading = false;
    update();
    return;
  }

  handleDelete() {
    log('handle click');
    return bottomConfirm(deleteFaq, title: "Delete FAQ");
  }

  deleteFaq() async {
    isLoading = true;
    update();
    final RequestResponseModel faq = await adminService.deleteFaq(id!);
    HC.snack(faq.message, success: faq.success);
    if (faq.success) Get.back();
    isLoading = false;
    update();
    return;
  }
}
