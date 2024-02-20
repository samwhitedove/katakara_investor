import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.function.dart';
import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/services.portfolio.dart';
import 'package:katakara_investor/values/values.dart';
import '../../../../models/receipt/model.fetch.reponse.dart';

class UserProductsController extends GetxController {
  bool isLoading = false;
  RxBool fetchingMore = false.obs;
  RxBool isFetching = false.obs;
  RxBool hasSearch = false.obs;

  List<PortfolioDatum>? searchedPortfolio = <PortfolioDatum>[];
  Pagination? searchPortfolioPagination;

  List<PortfolioDatum>? fetchedPortfolio = <PortfolioDatum>[];
  Pagination? pagination;

  // ignore: unused_field
  final _ = Get.put(AdminService());
  final AdminService adminService = Get.find<AdminService>();
  final PortfolioService portfolioService = Get.find<PortfolioService>();

  TextEditingController searchController = TextEditingController();

  List<String> productStatus = <String>[
    "PENDING",
    "REJECTED",
    "PUBLISHED",
    "APPROVED",
  ];

  int selected = 0;
  PortfolioDatum? selectedProduct;

  @override
  onInit() async {
    await fetchPortfolio();
    super.onInit();
  }

  viewProduct(int index) {
    return Get.toNamed(
      RouteName.viewUserPortfolio.name,
      arguments: fetchedPortfolio![index],
    );
  }

  fetchPortfolio([String? type]) async {
    log('$type start --- image');
    try {
      isLoading = true;
      update();
      if (type != null) selected = productStatus.indexOf(type);
      final RequestResponseModel response = type == null
          ? await adminService.fetchUsersPortfolio()
          : await adminService.fetchUsersPortfolio(data: {"category": type});
      isLoading = false;
      update();
      if (response.success) {
        final data = FetchPortfolioResponse.fromJson(response.toJson());
        fetchedPortfolio = data.data!.data!;
        pagination = data.data!.pagination;
        update();
      }
    } catch (e) {
      log('$e ---------------- datat');
    }
  }

  searchPortfolio() async {
    try {
      isFetching(true);
      HC.hideKeyBoard();

      update();
      final RequestResponseModel response =
          await adminService.searchPortfolio({"sku": searchController.text});
      isFetching(false);
      update();
      if (response.success) {
        final data = FetchPortfolioResponse.fromJson(response.toJson());
        if (data.data!.data!.isNotEmpty) hasSearch(true);
        searchedPortfolio = data.data!.data!;
        searchPortfolioPagination = data.data!.pagination;
        update();
      }
    } catch (e) {
      log('$e ---------------- datat');
    }
  }

  getMorePortfolio() async {
    fetchingMore.value = true;
    update();
    final RequestResponseModel response =
        await adminService.fetchMoreUserPortfolio(url: pagination!.nextPage);
    if (response.success) {
      log(response.data.toString());
      final data = FetchPortfolioResponse.fromJson(response.toJson());
      for (var element in data.data!.data!) {
        fetchedPortfolio!.add(element);
      }
      log(data.data!.pagination.toString());
      pagination = data.data!.pagination!;
      update();
    }
    fetchingMore.value = false;
  }

  updateStatus([String? action]) async {
    switch (action) {
      case "REJECTED":
        isLoading = true;
        update();
        final status =
            await adminService.rejectUsersPortfolio(selectedProduct!.sku!);
        HC.snack(status.message, success: status.success);
        break;
      case "PUBLISHED":
        isLoading = true;
        update();
        final status =
            await adminService.publishUsersPortfolio(selectedProduct!.sku!);
        HC.snack(status.message, success: status.success);
        break;
      case "APPROVED":
        isLoading = true;
        update();
        final status =
            await adminService.approveUsersPortfolio(selectedProduct!.sku!);
        HC.snack(status.message, success: status.success);
        break;
      default:
        break;
    }
    isLoading = false;
    update();
  }
}
