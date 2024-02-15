import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/models/receipt/model.receipt.item.dart';
import 'package:katakara_investor/models/receipt/models.receipt.preview.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/services/service.receipt.dart';
import 'package:katakara_investor/values/values.dart';

import '../../widgets/bottom.confirm.dart';

class ReceiptController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerAddress = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  List<ReceiptItemData> savedItem = <ReceiptItemData>[];
  final receiptService = Get.find<ReceiptService>();
  TextEditingController searchController = TextEditingController();

  RxBool isFetching = false.obs;
  RxBool hasSearch = false.obs;
  List<FetchedReceipt>? searchedReceipt = <FetchedReceipt>[];
  Pagination? searchReceiptPagination;

  bool isLoading = false;
  RxInt counter = 1.obs;
  RxBool fetchingMore = false.obs;
  int total = 0;
  String date = DateTime.now().toString().split(' ')[0].replaceAll('-', '/');
  List<FetchedReceipt>? fetchedReceipt = <FetchedReceipt>[];
  Pagination? pagination;

  int selected = -1;

  saveLocal() {
    update();
    Get.back();
  }

  searchReceipt() async {
    try {
      isFetching(true);
      HC.hideKeyBoard();

      update();
      final RequestResponseModel response =
          await receiptService.searchReceipt({"search": searchController.text});
      isFetching(false);
      update();
      if (response.success) {
        log(' ---------------- datat');
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
        await receiptService.fetchMoreReceipt(url: pagination!.nextPage);
    if (response.success) {
      final data = FetchReceiptResponseData.fromJson(response.toJson());
      for (var element in data.data!.data!) {
        fetchedReceipt!.add(element);
      }
      pagination = data.data!.pagination!;
      update();
    }
    fetchingMore.value = false;
  }

  Color handleStatusView(String status) {
    switch (status) {
      case "PENDING":
        return AppColor.grey;
      case "APPROVED":
        return AppColor.primary;
      case "REJECTED":
        return AppColor.red;
      default:
        return AppColor.grey;
    }
  }

  @override
  onInit() {
    fetchReceipt();
    super.onInit();
  }

  decrease() {
    if (counter.value == 1) return;
    counter.value -= 1;
  }

  increase() => counter.value += 1;

  calculateTotal() {
    total = 0;
    for (var i in savedItem) {
      total += int.parse(i.price!) * int.parse(i.quantity!);
    }
  }

  saveItem({bool isEdit = false, int? index}) {
    if (isEdit) {
      savedItem[index!].description = description.text;
      savedItem[index].price = amount.text;
      savedItem[index].itemName = itemName.text;
      savedItem[index].quantity = counter.value.toString();
    } else {
      savedItem.add(
        ReceiptItemData(
            description: description.text,
            price: amount.text,
            itemName: itemName.text,
            quantity: counter.value.toString()),
      );
    }

    calculateTotal();
    Get.back();
    counter.value = 1;
    description.clear();
    amount.clear();
    itemName.clear();
    update();
  }

  setData(ReceiptItemData data) {
    log(data.toJson().toString());
    description.text = data.description!;
    amount.text = data.price!;
    itemName.text = data.itemName!;
    counter.value = int.parse(data.quantity!);
  }

  removeItem(int index) {
    savedItem.removeAt(index);
    calculateTotal();
    update();
  }

  List<String> receiptMenu = <String>[
    "Receipt Title",
    "Customer Info",
    "Items",
  ];

  preview() => Get.toNamed(
        RouteName.receiptReview.name,
        arguments: ReceiptPreviewData(
          customerAddress: customerAddress.text,
          customerName: customerName.text,
          productInfo: savedItem,
          title: title.text,
          totalAmount: total.toString(),
          date: date,
          canShare: false,
          id: 00000000,
          isAdmin: false,
          status: "PENDING",
          receiptId: null,
        ),
      );

  viewReceipt(int index) {
    return Get.toNamed(
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
        isAdmin: false,
        canShare:
            fetchedReceipt![index].status == NewProductStatus.APPROVED.name,
        status: fetchedReceipt![index].status,
        id: fetchedReceipt![index].id,
      ),
    );
  }

  fetchReceipt({int? limit}) async {
    isLoading = true;
    update();
    final RequestResponseModel response =
        await receiptService.fetchReceipt(query: {"limit": limit ?? 10});
    isLoading = false;
    update();
    if (response.success) {
      final data = FetchReceiptResponseData.fromJson(response.toJson());
      fetchedReceipt = data.data?.data!;
      pagination = data.data!.pagination!;
      log("${fetchedReceipt!.length} lenght -----------2");
      update();
    }
  }

  void submit() async {
    final receipt = ReceiptPreviewData(
      customerAddress: customerAddress.text,
      customerName: customerName.text,
      productInfo: savedItem,
      title: title.text,
      totalAmount: total.toString(),
      date: date,
      receiptId: null,
    ).toJson();
    receipt.remove("date");
    receipt.remove("receiptId");
    receipt.remove("canShare");
    receipt.remove("isAdmin");
    receipt.remove("id");
    receipt.remove("status");
    isLoading = true;
    update();
    final RequestResponseModel response =
        await receiptService.saveReceipt(receipt);
    await fetchReceipt();
    isLoading = false;
    update();
    if (response.success) {
      Get.back();
      HC.snack(response.message, success: response.success);
      title.clear();
      customerName.clear();
      customerAddress.clear();
      itemName.clear();
      amount.clear();
      description.clear();
      savedItem.clear();
      total = 0;
      counter.value = 1;
      savedItem = <ReceiptItemData>[];
      return;
    }
    HC.snack(response.message, success: response.success);
  }

  checkQuantity(String qy) {
    if (qy.contains('.')) {
      return qy.split('.')[0];
    }
    return qy;
  }

  void share() {}

  RxBool isApproving = false.obs;
  RxBool isRejecting = false.obs;
  RxBool isDeleting = false.obs;
  // RxBool isWorking = false.obs;

  handleOperation(bool isDelete, int id, NewProductStatus approve) {
    if (isDelete) {
      return bottomConfirm(() => deleteReceipt(id),
          title: "Are you sure to delete receipt");
    }
    return bottomConfirm(
        () => approve == NewProductStatus.APPROVED
            ? approveReceipt(id)
            : rejectReceipt(id),
        title:
            "Are you sure to ${approve == NewProductStatus.APPROVED ? "approve" : "reject"} receipt");
  }

  void rejectReceipt(int id) async {
    final adminService = Get.find<AdminService>();
    isRejecting.value = true;
    final RequestResponseModel respnse = await adminService.rejectReceipts(id);
    if (respnse.success) {
      Get.back();
      await fetchReceipt(limit: fetchedReceipt!.length);
      update();
    }
    HC.snack(respnse.message, success: respnse.success);
    isRejecting.value = false;
  }

  void deleteReceipt(int id) async {
    final adminService = Get.find<AdminService>();
    isDeleting.value = true;
    final RequestResponseModel respnse = await adminService.deleteReceipts(id);
    if (respnse.success) {
      Get.back();
      await fetchReceipt(limit: fetchedReceipt!.length);
    }
    HC.snack(respnse.message, success: respnse.success);
    update();
    isDeleting.value = false;
  }

  void approveReceipt(int id) async {
    final adminService = Get.find<AdminService>();
    isApproving.value = true;
    final RequestResponseModel respnse = await adminService.approveReceipts(id);
    if (respnse.success) {
      Get.back();
      await fetchReceipt(limit: fetchedReceipt!.length);
      update();
    }
    HC.snack(respnse.message, success: respnse.success);
    isApproving.value = false;
  }

  changeUserType(String text) {
    if (receiptType[selected] == text) return;
    switch (text) {
      case "Pending":
        selected = 0;
        // pageType = UserViewType.all;
        // title = "All Users";
        update();
        break;
      case "Approved":
        selected = 1;
        // pageType = UserViewType.join;
        // title = "New Users";
        update();
        break;
      case "Rejected":
        selected = 2;
        // pageType = UserViewType.block;
        // title = "Block Users";
        update();
        break;
      default:
        selected = -1;
        // title = "All User";
        // pageType = UserViewType.all;
        update();
        break;
    }
    fetchReceipt();
  }
}
