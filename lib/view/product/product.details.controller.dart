import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.modal.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class ProductController extends GetxController {
  RxInt currentImageView = 0.obs;
  int imageLenght = 1;
  Timer? time;
  bool isGoingBack = false;
  PageController pageController = PageController();
  final portfolioService = Get.find<PortfolioService>();
  final portfolioView = Get.find<PortfolioController>();
  RxBool isDeleting = false.obs;

  @override
  void onClose() {
    time?.cancel();
    pageController.dispose();
    super.onClose();
  }

  Datum? product;

  @override
  void onInit() {
    product = Get.arguments;
    log(product!.toJson().toString());
    // product?.sellerImage?.removeWhere((item) => item.isEmpty);
    // startTimer();
    super.onInit();
  }

  // startTimer() {
  //   imageLenght = product?.productImage!.length ?? 0;
  //   if (imageLenght <= 1) return;
  //   time = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     log(currentImageView.value.toString());
  //     isGoingBack = (currentImageView.value + 1) == imageLenght;
  //     if (isGoingBack) {
  //       currentImageView.value = 0;
  //       pageController.animateToPage(currentImageView.value,
  //           duration: CW.onesSec, curve: Curves.easeInOut);
  //     } else {
  //       currentImageView.value += 1;
  //       pageController.nextPage(duration: CW.onesSec, curve: Curves.easeInOut);
  //     }
  //   });
  // }

  // changeView(value) {
  //   log(value.toString());
  //   currentImageView.value = value;
  // }

  handleDeleteProduct() {
    return warningModal(
      onSubmit: deleteProduct,
    );
  }

  deleteProduct() async {
    isDeleting.value = true;
    update();
    final RequestResponseModel response =
        await portfolioService.deleteProduct(product!.sku!);
    isDeleting.value = false;
    update();
    if (response.success) {
      HC.snack(response.message);
      portfolioView.fetchPortfolio();
      return Get.back();
    }
    HC.snack(response.message, success: response.success);
  }

  actionButtom() {
    return Get.toNamed(RouteName.addPortfolio.name, arguments: product);

    //TODO go to investment page to invest
  }
}
