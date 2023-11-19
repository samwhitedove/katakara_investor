import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/values/values.dart';

class PortfolioController extends GetxController {
  // List<String> productStatus = ["Products", /*"KFI",*/ "Sold"];
  int currentViewIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Datum> personalProduct = [];
  List<Datum> mergeProduct = [];
  final portfolioService = Get.find<PortfolioService>();
  RxBool isFetchingProducts = false.obs;
  RxBool isError = false.obs;
  String errorMessage = "";

  RxInt totalProduct = 0.obs;
  RxInt showing = 0.obs;

  void changeStatus(int index, {bool isClick = false}) {
    if (isClick) {
      pageController.animateToPage(index,
          curve: Curves.easeInOut, duration: CW.halfSec);
      return update();
    }
    currentViewIndex = index;
    update();
  }

  fetchPortfolio(
      {Map<String, dynamic> type = const {'type': 'personal'}}) async {
    isFetchingProducts.value = true;
    final RequestResponsModel response =
        await portfolioService.fetchPortfolio(query: type);
    if (response.success) {
      isError.value = false;
      final data = FetchPortfolioResponse.fromJson(response.toJson());
      if (type['type'] == 'merge') {
        mergeProduct = data.data!.data!;
      } else {
        personalProduct = data.data!.data!;
        totalProduct.value = data.data!.pagination!.total!;
        showing.value = data.data!.pagination!.currentPageItemCount! *
            data.data!.pagination!.currentPage!;
      }
      isFetchingProducts.value = false;
      return {'status': true};
    }
    errorMessage = response.message!;
    isError.value = true;
    return {'errorMessage': errorMessage, 'isError': isError, 'status': false};
  }

  addPortfolio() {
    return Get.toNamed(RouteName.addPortfolio.name);
  }
}
