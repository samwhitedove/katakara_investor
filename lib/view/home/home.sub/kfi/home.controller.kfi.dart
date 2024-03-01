import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/kfi/model.kfi.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.kfi.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class HomeKFIController extends GetxController {
  List<String> fkis = [tInvestments, tKFIAccount];
  RxInt currentKfi = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isInviting = false.obs;
  RxBool hasValidInput = false.obs;
  RxBool isErrorFetchingMergeProduct = false.obs;
  RxBool isErrorFetchingMergeUser = false.obs;
  RxBool isFetchingMerge = false.obs;
  List<MergeUsers> users = <MergeUsers>[];
  HomeScreenController? homeScreenController;
  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController();
  final kfiService = KFIService();

  changeEmailValue() => hasValidInput.value = HC.validateEmail(email.text);
  checkCode() => hasValidInput.value = code.text.length == 6;

  inviteUser() async {
    isInviting.value = true;
    final RequestResponseModel response =
        await kfiService.inviteUser(body: {'email': email.text});
    isInviting.value = false;
    Get.back();
    hasValidInput.value = false;
    email.clear();
    HC.snack(response.message, success: response.success);
  }

  acceptInvite() async {
    isInviting.value = true;
    final RequestResponseModel response =
        await kfiService.acceptUser(body: {'code': code.text});
    isInviting.value = false;
    Get.back();
    hasValidInput.value = false;
    code.clear();
    HC.snack(response.message, success: response.success);
  }

  PageController pageController = PageController(initialPage: 0);
  changeTab(index) {
    currentKfi.value = index;
  }

  RxString errorMessage = ''.obs;
  List<PortfolioDatum> kfiProduct = [];

  Future<List<PortfolioDatum>> fetchKFIInvestment() async {
    isErrorFetchingMergeProduct.value = false;
    isLoading.value = true;
    Get.put(PortfolioController());
    final portfolioController = Get.find<PortfolioController>();
    final data =
        await portfolioController.fetchPortfolio(type: {'type': 'merge'});
    if (data['status'] == false) {
      isErrorFetchingMergeProduct.value = true;
      errorMessage.value = data['errorMessage'];
    }
    kfiProduct = portfolioController.mergeProduct;
    isLoading.value = false;
    return portfolioController.mergeProduct;
  }

  Future fetchKFIAccount() async {
    isErrorFetchingMergeUser.value = false;
    isFetchingMerge.value = true;
    final RequestResponseModel response = await kfiService.fetchMergeUser();
    isFetchingMerge.value = false;
    if (response.success == false) {
      isErrorFetchingMergeUser.value = true;
      HC.snack(response.message, success: response.success);
      return;
    }
    users.clear();
    for (var user in response.data) {
      users.add(MergeUsers.fromJson(user));
    }
  }

  RxBool isUnlinking = false.obs;
  Future unlinkUser(String email) async {
    isUnlinking.value = true;
    final RequestResponseModel response =
        await kfiService.unlinkUser(body: {"email": email});
    isUnlinking.value = false;
    if (response.success) fetchKFIAccount();
    Get.back();
    HC.snack(response.message, success: response.success);
    return;
  }
}
