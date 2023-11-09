import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class HomeKFIController extends GetxController {
  List<String> fkis = [tInvestments, tKFIAccount];
  RxInt currentKfi = 0.obs;
  RxBool isLoading = false.obs;
  HomeScreenController? homeScreenController;

  List<Map<String, dynamic>> fkiData = [
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun']
    },
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Mon', 'Sun']
    },
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Mon', 'Tue', 'Wed', 'Thur', 'Sun']
    },
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Mon', 'Tue', 'Wed', 'Thur', 'Fri']
    },
    {
      'name': "Emeka Emaku Alios",
      'state': 'Abuja',
      'lga': "Gwaladwa",
      'workDays': ['Thur', 'Fri', 'Sat', 'Sun']
    }
  ];

  PageController pageController = PageController(initialPage: 0);
  changeTab(index) {
    currentKfi.value = index;
    pageController.animateToPage(currentKfi.value,
        duration: CW.onesSec, curve: Curves.fastEaseInToSlowEaseOut);
  }

  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  List<Datum> kfiProduct = [];
  Future<List<Datum>> fetchKFIInvestment() async {
    isLoading.value = true;
    Get.put(PortfolioController());
    final portfolioController = Get.find<PortfolioController>();
    final data =
        await portfolioController.fetchPortfolio(type: {'type': 'merge'});
    if (data['status'] == false) {
      isError.value = true;
      errorMessage.value = data['errorMessage'];
    }
    kfiProduct = portfolioController.mergeProduct;
    isLoading.value = false;
    return portfolioController.mergeProduct;
  }

  Future<Map<String, dynamic>> fetchKFIAccount() async {
    return {"message": "messate", "data": []};
  }

  // findKFI(int value) async {
  //   homeScreenController!.isLoading.value = true;
  //   isLoading.value = true;
  //   await Future.delayed(CW.onesSec);
  //   currentKfi.value = value;
  //   isLoading.value = false;
  //   homeScreenController!.isLoading.value = false;
  // }
}
