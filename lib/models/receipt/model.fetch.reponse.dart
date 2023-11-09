// To parse this JSON data, do
//
//     final fetchReceiptResponseData = fetchReceiptResponseDataFromJson(jsonString);

import 'dart:convert';

FetchReceiptResponseData fetchReceiptResponseDataFromJson(String str) =>
    FetchReceiptResponseData.fromJson(json.decode(str));

String fetchReceiptResponseDataToJson(FetchReceiptResponseData data) =>
    json.encode(data.toJson());

class FetchReceiptResponseData {
  String? message;
  int? statusCode;
  Data? data;
  bool? success;

  FetchReceiptResponseData({
    this.message,
    this.statusCode,
    this.data,
    this.success,
  });

  factory FetchReceiptResponseData.fromJson(Map<String, dynamic> json) =>
      FetchReceiptResponseData(
        message: json["message"],
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "data": data?.toJson(),
        "success": success,
      };
}

class Data {
  List<Fetched>? fetched;
  Pagination? pagination;

  Data({
    this.fetched,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fetched: json["fetched"] == null
            ? []
            : List<Fetched>.from(
                json["fetched"]!.map((x) => Fetched.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "fetched": fetched == null
            ? []
            : List<dynamic>.from(fetched!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Fetched {
  int? id;
  String? customerName;
  String? customerAddress;
  String? totalAmount;
  bool? isApproved;
  String? receiptCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ReceiptProductInfo>? receiptProductInfo;

  Fetched({
    this.id,
    this.customerName,
    this.customerAddress,
    this.totalAmount,
    this.isApproved,
    this.receiptCode,
    this.createdAt,
    this.updatedAt,
    this.receiptProductInfo,
  });

  factory Fetched.fromJson(Map<String, dynamic> json) => Fetched(
        id: json["id"],
        customerName: json["customerName"],
        customerAddress: json["customerAddress"],
        totalAmount: json["totalAmount"],
        isApproved: json["isApproved"],
        receiptCode: json["receiptCode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        receiptProductInfo: json["receiptProductInfo"] == null
            ? []
            : List<ReceiptProductInfo>.from(json["receiptProductInfo"]!
                .map((x) => ReceiptProductInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerName": customerName,
        "customerAddress": customerAddress,
        "totalAmount": totalAmount,
        "isApproved": isApproved,
        "receiptCode": receiptCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "receiptProductInfo": receiptProductInfo == null
            ? []
            : List<dynamic>.from(receiptProductInfo!.map((x) => x.toJson())),
      };
}

class ReceiptProductInfo {
  int? id;
  String? itemName;
  String? price;
  String? quantity;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  ReceiptProductInfo({
    this.id,
    this.itemName,
    this.price,
    this.quantity,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory ReceiptProductInfo.fromJson(Map<String, dynamic> json) =>
      ReceiptProductInfo(
        id: json["id"],
        itemName: json["itemName"],
        price: json["price"],
        quantity: json["quantity"],
        description: json["description"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemName": itemName,
        "price": price,
        "quantity": quantity,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Pagination {
  int? count;
  int? totalPage;
  int? perPage;
  int? currentPageItemCount;
  int? currentPage;
  dynamic previousPage;
  dynamic nextPage;

  Pagination({
    this.count,
    this.totalPage,
    this.perPage,
    this.currentPageItemCount,
    this.currentPage,
    this.previousPage,
    this.nextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        count: json["count"],
        totalPage: json["totalPage"],
        perPage: json["perPage"],
        currentPageItemCount: json["currentPageItemCount"],
        currentPage: json["currentPage"],
        previousPage: json["previousPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "totalPage": totalPage,
        "perPage": perPage,
        "currentPageItemCount": currentPageItemCount,
        "currentPage": currentPage,
        "previousPage": previousPage,
        "nextPage": nextPage,
      };
}
