// To parse this JSON data, do
//
//     final receiptPreviewData = receiptPreviewDataFromJson(jsonString);

import 'dart:convert';

import 'package:katakara_investor/models/receipt/model.receipt.item.dart';

ReceiptPreviewData receiptPreviewDataFromJson(String str) =>
    ReceiptPreviewData.fromJson(json.decode(str));

String receiptPreviewDataToJson(ReceiptPreviewData data) =>
    json.encode(data.toJson());

class ReceiptPreviewData {
  String? title;
  String? customerName;
  String? customerAddress;
  List<ReceiptItemData>? productInfo;
  String? totalAmount;
  String? date;
  String? receiptId;

  ReceiptPreviewData({
    this.title,
    this.customerName,
    this.customerAddress,
    this.productInfo,
    this.totalAmount,
    this.date,
    this.receiptId,
  });

  factory ReceiptPreviewData.fromJson(Map<String, dynamic> json) =>
      ReceiptPreviewData(
        title: json["title"],
        customerName: json["customerName"],
        customerAddress: json["customerAddress"],
        productInfo: json["productInfo"] == null
            ? []
            : List<ReceiptItemData>.from(
                json["items"]!.map((x) => ReceiptItemData.fromJson(x))),
        totalAmount: json["totalAmount"],
        date: json["date"],
        receiptId: json["receiptId"],
      );

  get receiptProductInfo => null;

  Map<String, dynamic> toJson() => {
        "title": title,
        "customerName": customerName,
        "customerAddress": customerAddress,
        "productInfo": productInfo == null
            ? []
            : List<dynamic>.from(productInfo!.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "date": date,
        "receiptId": receiptId,
      };
}
