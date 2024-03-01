import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/models/product/model.category.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/services.home.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/values/strings.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';

import '../../../../models/receipt/model.fetch.reponse.dart';

class AdminInvestmentActiveController extends GetxController {
  bool isLoading = false;
  RxBool fetchingMore = false.obs;
  RxBool isFetching = false.obs;
  RxBool hasSearch = false.obs;

  List<InvestmentDatum>? searchedInvestment = <InvestmentDatum>[];
  Pagination? searchInvestmentPagination;

  List<InvestmentDatum>? fetchedInvestment = <InvestmentDatum>[];
  Pagination? pagination;

  final HomeService homeService = Get.find<HomeService>();
  final PortfolioService portfolioService = Get.find<PortfolioService>();

  TextEditingController searchController = TextEditingController();

  List<String> fetchCategory = <String>[];
  RxBool isDeletingInvestment = false.obs;

  int selected = 0;

  @override
  onInit() async {
    await fetchProductCategory();
    await fetchInvestment();
    super.onInit();
  }

  List<String> states = stateAndLga.keys.toList()..replaceRange(0, 1, ["ALL"]);
  RxString selectedState = "ALL".obs;
  RxString selectedCategory = "ALL".obs;

  RxBool hasFilter = false.obs;

  fetchProductCategory() async {
    isLoading = true;
    final response = await portfolioService.fetchProductCategory();
    if (response.success) {
      fetchCategory.clear();
      List data = response.data ?? [];
      if (data.isNotEmpty) {
        fetchCategory.add("ALL");
        for (var element in data) {
          fetchCategory.add(Category.fromJson(element).category.toString());
        }
      }
      isLoading = false;
    }
    isLoading = false;
  }

  viewInvestment(int index) {
    return Get.toNamed(
      RouteName.investmentView.name,
      arguments: fetchedInvestment![index],
    );
  }

  fetchInvestment([String? category, String? state]) async {
    log('$category start --- image');
    try {
      isLoading = true;
      update();
      final response = await homeService.filterInvestment({
        if (category != null && category != "ALL") "category": category,
        if (state != null && state != "ALL") "state": state
      });
      isLoading = false;
      update();
      if (response.success) {
        fetchedInvestment?.clear();

        final data = InvestmentData.fromJson(response.data);
        fetchedInvestment = data.data!;
        pagination = data.pagination;
        update();
      }
    } catch (e) {
      log('$e ---------------- datat error');
    }
  }

  filterInvestment() async {
    Get.back();
    String? select;
    if (selectedState.value != "ALL") select = selectedState.value;
    await fetchInvestment(selectedCategory.value, select);
  }

  clearFilter() async {
    Get.back();
    if (selectedCategory.value == "ALL" && selectedState.value == "ALL") return;
    await fetchInvestment();
    selectedCategory.value = "ALL";
    selectedState.value = "ALL";
  }

  searchReceipt() async {
    try {
      HC.hideKeyBoard();
      isFetching(true);
      update();
      final RequestResponseModel response = searchController.text
              .startsWith("IST")
          ? await homeService.searchInvestment({"sku": searchController.text})
          : await homeService
              .searchInvestment({"productName": searchController.text});
      isFetching(false);
      update();
      if (response.success) {
        searchedInvestment!.clear();
        final data = InvestmentData.fromJson(response.data);
        if (data.data!.isNotEmpty) hasSearch(true);
        searchedInvestment = data.data!;
        searchInvestmentPagination = data.pagination;
        update();
      }
    } catch (e) {
      log('$e ---------------- datat');
    }
  }

  deleteInvestment(String sku) async {
    isDeletingInvestment.value = true;
    update();
    final RequestResponseModel response =
        await AdminService().deleteInvestment({"sku": sku});
    isDeletingInvestment.value = false;
    update();
    HC.snack(response.message, success: response.success);
    if (response.success) {
      Get.back();
      await fetchInvestment(fetchCategory[selected]);
      update();
    }
  }

  getMoreInvestment() async {
    fetchingMore.value = true;
    update();
    final RequestResponseModel response =
        await homeService.fetchMoreInvestment(url: pagination!.nextPage);
    fetchingMore.value = false;
    if (response.success) {
      final data = InvestmentData.fromJson(response.data);
      // fetchedInvestment = data.data!;
      fetchedInvestment!.addAll(data.data!);
      pagination = data.pagination;
      update();
    }
    if (response.success) {
      final data = InvestmentData.fromJson(response.toJson());
      for (var element in data.data!) {
        fetchedInvestment!.add(element);
      }
      pagination = data.pagination!;
      update();
    }
    fetchingMore.value = false;
  }

  changeCategory(String text) {
    selectedCategory.value = text;
    hasFilter.value = selectedCategory.value != "ALL" || text != "ALL";
  }

  changeState(String text) {
    selectedState.value = text;
    hasFilter.value = text != "ALL" || selectedState.value != "ALL";
  }
}
