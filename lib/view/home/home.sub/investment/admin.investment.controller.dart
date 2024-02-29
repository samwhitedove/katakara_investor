import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/models/product/model.category.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/values/strings.dart';
import 'package:katakara_investor/view/admin/investment/active/model.response.dart';

import '../../../../models/receipt/model.fetch.reponse.dart';

class UploadedProductController extends GetxController {
  bool isLoading = false;
  RxBool fetchingMore = false.obs;
  RxBool isFetching = false.obs;
  RxBool hasSearch = false.obs;

  List<InvestmentDatum>? searchedInvestment = <InvestmentDatum>[];
  Pagination? searchInvestmentPagination;

  List<InvestmentDatum>? fetchedInvestment = <InvestmentDatum>[];
  Pagination? pagination;

  final AdminService adminService = Get.find<AdminService>();
  final PortfolioService portfolioService = Get.find<PortfolioService>();

  TextEditingController searchController = TextEditingController();

  List<String> fetchCategory = <String>[];

  int selected = 0;

  @override
  onInit() async {
    await fetchProductCategory();
    await fetchInvestment();
    super.onInit();
  }

  fetchProductCategory() async {
    isLoading = true;
    final RequestResponseModel response =
        await portfolioService.fetchProductCategory();
    if (response.success) {
      fetchCategory.clear();
      List data = response.data ?? [];
      if (data.isNotEmpty) {
        fetchCategory.add("All");
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

  fetchInvestment([String? type]) async {
    log('$type start --- image');
    try {
      isLoading = true;
      update();
      if (type != null) selected = fetchCategory.indexOf(type);
      final RequestResponseModel response = type == null
          ? await adminService.fetchInvestment()
          : await adminService.filterInvestment({"category": type});
      isLoading = false;
      update();
      if (response.success) {
        final data = InvestmentData.fromJson(response.toJson());
        fetchedInvestment = data.data!;
        pagination = data.pagination;
        update();
      }
    } catch (e) {
      log('$e ---------------- datat');
    }
  }

  searchReceipt() async {
    try {
      isFetching(true);
      HC.hideKeyBoard();

      update();
      final RequestResponseModel response = searchController.text
              .startsWith("IST")
          ? await adminService.searchInvestment({"sku": searchController.text})
          : await adminService
              .searchInvestment({"productName": searchController.text});
      isFetching(false);
      update();
      if (response.success) {
        final data = InvestmentData.fromJson(response.toJson());
        if (data.data!.isNotEmpty) hasSearch(true);
        searchedInvestment = data.data!;
        searchInvestmentPagination = data.pagination;
        update();
      }
    } catch (e) {
      log('$e ---------------- datat');
    }
  }

  getMoreInvestment() async {
    fetchingMore.value = true;
    update();
    final RequestResponseModel response =
        await adminService.fetchMoreInvestment(url: pagination!.nextPage);
    if (response.success) {
      log(response.data.toString());
      final data = InvestmentData.fromJson(response.toJson());
      for (var element in data.data!) {
        fetchedInvestment!.add(element);
      }
      log(data.pagination.toString());
      pagination = data.pagination!;
      update();
    }
    fetchingMore.value = false;
  }
}
