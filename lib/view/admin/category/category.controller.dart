import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/product/model.category.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/services.portfolio.dart';

class AddCategoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isUpdating = false.obs;
  RxBool isFetching = false.obs;
  RxBool isGood = false.obs;
  final PortfolioService portfolioService = Get.find<PortfolioService>();
  final AdminService adminService = Get.find<AdminService>();
  List<Category> categories = [];

  TextEditingController? category;

  @override
  void onInit() {
    category = TextEditingController();
    fetchCategory();
    super.onInit();
  }

  checkInput() {
    isGood.value = category!.text.isNotEmpty;
  }

  fetchCategory() async {
    isFetching.value = true;
    update();
    final cat = await portfolioService.fetchProductCategory();
    isFetching.value = false;
    update();
    if (cat.success) {
      HC.snack(cat.message, success: cat.success);
      List data = cat.data ?? [];
      categories.clear();
      if (data.isNotEmpty) {
        for (var element in data) {
          categories.add(Category.fromJson(element));
        }
        // cat.value = categories.first;
        log(categories.toString());
      }
    }
    HC.snack(cat.message, success: cat.success);
  }

  deleteCategory(int index) async {
    isFetching.value = true;
    final cat =
        await adminService.deleteCategory({"id": categories[index].id!});
    isFetching.value = false;
    if (cat.success) {
      HC.snack(cat.message, success: cat.success);
      fetchCategory();
    }
    HC.snack(cat.message, success: cat.success);
  }

  save() async {
    HC.hideKeyBoard();
    isLoading.value = true;
    update();
    final RequestResponseModel save =
        await adminService.addCategory({'category': category!.text});
    isLoading.value = false;
    update();
    if (save.success) {
      fetchCategory();
      Get.back();
      category!.clear();
    }
    HC.snack(save.message, success: save.success);
    return;
  }

  updateCat(int index) async {
    HC.hideKeyBoard();
    isLoading.value = true;
    update();
    final RequestResponseModel updates = await adminService.updateCategory(
        {'category': category!.text, "id": categories[index].id!});
    isLoading.value = false;
    update();
    if (updates.success) {
      fetchCategory();
      Get.back();
      category!.clear();
    }

    HC.snack(updates.message, success: updates.success);
    return;
  }
}
