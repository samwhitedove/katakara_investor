// To parse this JSON data, do
//
//     final investmentResponseDataModel = investmentResponseDataModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/receipt/model.fetch.reponse.dart';

InvestmentResponseDataModel investmentResponseDataModelFromJson(String str) =>
    InvestmentResponseDataModel.fromJson(json.decode(str));

String investmentResponseDataModelToJson(InvestmentResponseDataModel data) =>
    json.encode(data.toJson());

class InvestmentResponseDataModel {
  String? message;
  int? statusCode;
  InvestmentData? data;
  bool? success;

  InvestmentResponseDataModel({
    this.message,
    this.statusCode,
    this.data,
    this.success,
  });

  factory InvestmentResponseDataModel.fromJson(Map<String, dynamic> json) =>
      InvestmentResponseDataModel(
        message: json["message"],
        statusCode: json["statusCode"],
        data:
            json["data"] == null ? null : InvestmentData.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "data": data?.toJson(),
        "success": success,
      };
}

class InvestmentData {
  List<InvestmentDatum>? data;
  Pagination? pagination;

  InvestmentData({
    this.data,
    this.pagination,
  });

  factory InvestmentData.fromJson(Map<String, dynamic> json) => InvestmentData(
        data: json["data"] == null
            ? []
            : List<InvestmentDatum>.from(
                json["data"]!.map((x) => InvestmentDatum.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class InvestmentDatum {
  int? id;
  String? productImage;
  String? productName;
  String? state;
  String? lga;
  String? description;
  String? category;
  String? amount;
  String? sku;
  String? sellerName;
  String? sellerAddress;
  DateTime? createdAt;
  DateTime? updatedAt;

  InvestmentDatum({
    this.id,
    this.productImage,
    this.productName,
    this.state,
    this.lga,
    this.description,
    this.category,
    this.amount,
    this.sku,
    this.sellerName,
    this.sellerAddress,
    this.createdAt,
    this.updatedAt,
  });

  factory InvestmentDatum.fromJson(Map<String, dynamic> json) =>
      InvestmentDatum(
        id: json["id"],
        productImage: json["productImage"],
        productName: json["productName"],
        state: json["state"],
        lga: json["lga"],
        description: json["description"],
        category: json["category"],
        amount: json["amount"],
        sku: json["sku"],
        sellerName: json["sellerName"],
        sellerAddress: json["sellerAddress"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productImage": productImage,
        "productName": productName,
        "state": state,
        "lga": lga,
        "description": description,
        "category": category,
        "amount": amount,
        "sku": sku,
        "sellerName": sellerName,
        "sellerAddress": sellerAddress,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
