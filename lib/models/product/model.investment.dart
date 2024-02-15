// To parse this JSON data, do
//
//     final investmentDataModel = investmentDataModelFromJson(jsonString);

import 'dart:convert';

InvestmentDataModel investmentDataModelFromJson(String str) =>
    InvestmentDataModel.fromJson(json.decode(str));

String investmentDataModelToJson(InvestmentDataModel data) =>
    json.encode(data.toJson());

class InvestmentDataModel {
  List<String>? productImage;
  String? productName;
  String? state;
  String? lga;
  String? sellerName;
  String? category;
  String? description;
  String? amount;
  String? sellerAddress;

  InvestmentDataModel({
    this.productImage,
    this.productName,
    this.state,
    this.lga,
    this.sellerName,
    this.category,
    this.description,
    this.amount,
    this.sellerAddress,
  });

  factory InvestmentDataModel.fromJson(Map<String, dynamic> json) =>
      InvestmentDataModel(
        productImage: json["productImage"] == null
            ? []
            : List<String>.from(json["productImage"]!.map((x) => x)),
        productName: json["productName"],
        state: json["state"],
        lga: json["lga"],
        sellerName: json["sellerName"],
        category: json["category"],
        description: json["description"],
        amount: json["amount"],
        sellerAddress: json["sellerAddress"],
      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage == null
            ? []
            : List<dynamic>.from(productImage!.map((x) => x)),
        "productName": productName,
        "state": state,
        "lga": lga,
        "sellerName": sellerName,
        "category": category,
        "description": description,
        "amount": amount,
        "sellerAddress": sellerAddress,
      };
}
