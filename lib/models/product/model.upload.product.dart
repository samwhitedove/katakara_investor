// To parse this JSON data, do
//
//     final uploadProductModel = uploadProductModelFromJson(jsonString);

import 'dart:convert';

UploadProductModel uploadProductModelFromJson(String str) =>
    UploadProductModel.fromJson(json.decode(str));

String uploadProductModelToJson(UploadProductModel data) =>
    json.encode(data.toJson());

class UploadProductModel {
  List<String>? productImage;
  String? productName;
  String? state;
  String? lga;
  String? description;
  String? amountBuy;
  // String? amount;
  String? category;
  String? expenditureAmount;
  String? expenditureDescription;
  List<String>? sellerImage;

  UploadProductModel({
    this.productImage,
    this.productName,
    this.state,
    this.lga,
    this.description,
    // this.amount,
    this.category,
    this.expenditureAmount,
    this.expenditureDescription,
    this.amountBuy,
    this.sellerImage,
  });

  factory UploadProductModel.fromJson(Map<String, dynamic> json) =>
      UploadProductModel(
        productImage: json["productImage"] == null
            ? []
            : List<String>.from(json["productImage"]!.map((x) => x)),
        productName: json["productName"],
        state: json["state"],
        lga: json["lga"],
        description: json["description"],
        // amount: json["amount"],
        category: json["category"],
        expenditureAmount: json["expenditureAmount"],
        expenditureDescription: json["expenditureDescription"],
        amountBuy: json["amountBuy"],
        sellerImage: json["sellerImage"],
      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage == null
            ? []
            : List<dynamic>.from(productImage!.map((x) => x)),
        "productName": productName,
        "state": state,
        "lga": lga,
        "category": category,
        "expenditureAmount": expenditureAmount,
        "expenditureDescription": expenditureDescription,
        "amountBuy": amountBuy,
        "description": description,
        // "amount": amount,
        "sellerImage": sellerImage,
      };
}
