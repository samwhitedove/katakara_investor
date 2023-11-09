import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/models/receipt/model.receipt.item.dart';
import 'package:katakara_investor/models/receipt/models.receipt.preview.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.receipt.dart';
import 'package:katakara_investor/values/values.dart';

class ReceiptController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerAddress = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  List<ReceiptItemData> savedItem = <ReceiptItemData>[];
  final receiptService = Get.find<ReceiptService>();
  bool isLoading = false;
  RxInt counter = 1.obs;
  int total = 0;
  String date = DateTime.now().toString().split(' ')[0].replaceAll('-', '/');
  List<Fetched>? fetchedReceipt = <Fetched>[];
  Pagination? pagiantion;

  saveLocal() {
    update();
    Get.back();
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
          receiptId: null,
        ),
      );

  viewReceipt(int index) => Get.toNamed(
        RouteName.receiptReview.name,
        arguments: ReceiptPreviewData(
          customerAddress: fetchedReceipt![index].customerAddress,
          customerName: fetchedReceipt![index].customerName,
          productInfo: fetchedReceipt![index]
              .receiptProductInfo!
              .map((element) => ReceiptItemData.fromJson(element.toJson()))
              .toList(),
          // TODOD Fixed
          title: fetchedReceipt![index].totalAmount.toString(),
          totalAmount: fetchedReceipt![index].totalAmount,
          date: fetchedReceipt![index].createdAt.toString().split(" ")[0],
          receiptId: fetchedReceipt![index].receiptCode,
        ),
        parameters: {"share": fetchedReceipt![index].isApproved.toString()},
      );

  fetchReceipt() async {
    isLoading = true;
    update();
    final RequestResponsModel response = await receiptService.fetchReceipt();
    isLoading = false;
    update();
    if (response.success) {
      final data = FetchReceiptResponseData.fromJson(response.toJson());
      fetchedReceipt = data.data?.fetched!;
      pagiantion = data.data!.pagination!;
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
    isLoading = true;
    update();
    final RequestResponsModel response =
        await receiptService.saveReceipt(receipt);
    await fetchReceipt();
    isLoading = false;
    Get.back();
    update();
    if (response.success) {
      HC.snack(response.message);
      return;
    }
    HC.snack(response.message);
  }
}
