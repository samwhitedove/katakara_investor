import 'dart:convert';

import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';

FetchPortfolioResponse fetchPortfolioResponseFromJson(String str) =>
    FetchPortfolioResponse.fromJson(json.decode(str));

String fetchPortfolioResponseToJson(FetchPortfolioResponse data) =>
    json.encode(data.toJson());

class FetchPortfolioResponse {
  String? message;
  int? statusCode;
  Data? data;
  bool? success;

  FetchPortfolioResponse({
    this.message,
    this.statusCode,
    this.data,
    this.success,
  });

  factory FetchPortfolioResponse.fromJson(Map<String, dynamic> json) =>
      FetchPortfolioResponse(
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
  List<PortfolioDatum>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<PortfolioDatum>.from(
                json["data"]!.map((x) => PortfolioDatum.fromJson(x))),
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

enum ProductStatus { PENDING, REJECTED, ACTIVE, RESOLVED }

handleStatus(String status) {
  switch (status) {
    case "PENDING":
      return (ProductStatus.PENDING, "PENDING");
    case "REJECTED":
      return (ProductStatus.REJECTED, "REJECTED");
    case "ACTIVE":
      return (ProductStatus.ACTIVE, "ACTIVE");
    case "RESOLVED":
      return (ProductStatus.RESOLVED, "RESOLVED");
    default:
      return (ProductStatus.PENDING, "PENDING");
  }
}

class PortfolioDatum {
  int? id;
  List? productImage;
  String? productName;
  String? state;
  String? lga;
  String? description;
  String? category;
  String? amount;
  String? sku;
  dynamic amountBuy;
  dynamic sellerImage;
  (ProductStatus, String)? status;
  bool? isPublished;
  bool? isMerge;
  DateTime? createdAt;
  DateTime? updatedAt;

  PortfolioDatum({
    this.id,
    this.productImage,
    this.productName,
    this.state,
    this.lga,
    this.description,
    this.category,
    this.amount,
    this.sku,
    this.status,
    this.amountBuy,
    this.sellerImage,
    this.isPublished,
    this.isMerge,
    this.createdAt,
    this.updatedAt,
  });

  factory PortfolioDatum.fromJson(Map<String, dynamic> json) => PortfolioDatum(
        id: json["id"],
        productImage: json["productImage"].split(","),
        productName: json["productName"],
        state: json["state"],
        lga: json["lga"],
        description: json["description"],
        category: json["category"],
        amount: json["amount"],
        sku: json["sku"],
        status: handleStatus(json["status"]),
        amountBuy: json["amountBuy"],
        sellerImage: json["sellerImage"].split(","),
        isPublished: json["isPublished"],
        isMerge: json["isMerge"],
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
        "status": status,
        "amountBuy": amountBuy,
        "sellerImage": sellerImage,
        "isPublished": isPublished,
        "isMerge": isMerge,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

// class Pagination {
//   int? total;
//   int? totalPage;
//   int? perPage;
//   int? currentPageItemCount;
//   int? currentPage;
//   dynamic previousPage;
//   String? nextPage;

//   Pagination({
//     this.total,
//     this.totalPage,
//     this.perPage,
//     this.currentPageItemCount,
//     this.currentPage,
//     this.previousPage,
//     this.nextPage,
//   });

//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         totalPage: json["totalPage"],
//         perPage: json["perPage"],
//         currentPageItemCount: json["currentPageItemCount"],
//         currentPage: json["currentPage"],
//         previousPage: json["previousPage"],
//         nextPage: json["nextPage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "total": total,
//         "totalPage": totalPage,
//         "perPage": perPage,
//         "currentPageItemCount": currentPageItemCount,
//         "currentPage": currentPage,
//         "previousPage": previousPage,
//         "nextPage": nextPage,
//       };
// }
