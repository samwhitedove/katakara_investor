import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/services/service.admin.dart';

import '../../../models/receipt/model.fetch.reponse.dart';
import '../../../models/receipt/model.receipt.item.dart';
import '../../../models/receipt/models.receipt.preview.dart';
import '../../../models/services/model.service.response.dart';
import '../../../values/strings.dart';

class AdminReceiptController extends GetxController {
  bool isLoading = false;
  RxBool fetchingMore = false.obs;
  RxBool isFetching = false.obs;
  RxBool hasSearch = false.obs;
  List<FetchedReceipt>? searchedReceipt = <FetchedReceipt>[];
  Pagination? searchReceiptPagination;
  List<FetchedReceipt>? fetchedReceipt = <FetchedReceipt>[];
  Pagination? pagination;
  final AdminService adminService = Get.find<AdminService>();
  TextEditingController searchController = TextEditingController();

  int selected = 1;

  @override
  onInit() {
    fetchReceipt();
    super.onInit();
  }

  viewReceipt(int index) => Get.toNamed(
        RouteName.receiptReview.name,
        arguments: ReceiptPreviewData(
          customerAddress: fetchedReceipt![index].customerAddress,
          customerName: fetchedReceipt![index].customerName,
          productInfo: fetchedReceipt![index]
              .receiptProductInfo!
              .map((element) => ReceiptItemData.fromJson(element.toJson()))
              .toList(),
          title: fetchedReceipt![index].totalAmount.toString(),
          totalAmount: fetchedReceipt![index].totalAmount,
          date: fetchedReceipt![index].createdAt.toString().split(" ")[0],
          receiptId: fetchedReceipt![index].receiptCode,
          canShare: false,
          isAdmin: true,
          id: fetchedReceipt![index].id,
          status: fetchedReceipt![index].status,
        ),
      );

  fetchReceipt() async {
    try {
      isLoading = true;
      update();
      final RequestResponseModel response = (selected == 0)
          ? await adminService.fetchUsersReceipt()
          : await adminService
              .fetchSortUsersReceipt(data: {"type": receiptType[selected]});
      isLoading = false;
      update();
      if (response.success) {
        final data = FetchReceiptResponseData.fromJson(response.toJson());
        fetchedReceipt = data.data!.data;
        pagination = data.data!.pagination;
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
      final RequestResponseModel response = await adminService
          .fetchSortUsersReceipt(data: {"search": searchController.text});
      isFetching(false);
      update();
      if (response.success) {
        final data = FetchReceiptResponseData.fromJson(response.toJson());
        if (data.data!.data!.isNotEmpty) hasSearch(true);
        searchedReceipt = data.data!.data;
        searchReceiptPagination = data.data!.pagination;
        update();
      }
    } catch (e) {
      log('$e ---------------- datat');
    }
  }

  getMoreReceipt() async {
    fetchingMore.value = true;
    update();
    final RequestResponseModel response =
        await adminService.fetchMoreUsersReceipt(url: pagination!.nextPage);
    if (response.success) {
      log(response.data.toString());
      final data = FetchReceiptResponseData.fromJson(response.toJson());
      for (var element in data.data!.data!) {
        fetchedReceipt!.add(element);
      }
      log(data.data!.pagination.toString());
      pagination = data.data!.pagination!;
      update();
    }
    fetchingMore.value = false;
  }

  changeUserType(String text) {
    if (receiptType[selected] == text) return;
    switch (text) {
      case "All":
        selected = 0;
        update();
        break;
      case "PENDING":
        selected = 1;
        update();
        break;
      case "APPROVED":
        selected = 2;
        update();
        break;
      case "REJECTED":
        selected = 3;
        update();
        break;
      default:
        selected = 0;
        update();
        break;
    }
    fetchReceipt();
  }
}
