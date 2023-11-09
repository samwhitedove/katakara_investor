// // To parse this JSON data, do
// //
// //     final fetchPortfolioResponse = fetchPortfolioResponseFromJson(jsonString);

// import 'dart:convert';

// FetchPortfolioResponse fetchPortfolioResponseFromJson(String str) =>
//     FetchPortfolioResponse.fromJson(json.decode(str));

// String fetchPortfolioResponseToJson(FetchPortfolioResponse data) =>
//     json.encode(data.toJson());

// class FetchPortfolioResponse {
//   String? message;
//   int? statusCode;
//   Data? data;
//   bool? success;

//   FetchPortfolioResponse({
//     this.message,
//     this.statusCode,
//     this.data,
//     this.success,
//   });

//   factory FetchPortfolioResponse.fromJson(Map<String, dynamic> json) =>
//       FetchPortfolioResponse(
//         message: json["message"],
//         statusCode: json["statusCode"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         success: json["success"],
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "statusCode": statusCode,
//         "data": data?.toJson(),
//         "success": success,
//       };
// }

// class Data {
//   List<Merge>? personal;
//   List<Merge>? merge;

//   Data({
//     this.personal,
//     this.merge,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         personal: json["personal"] == null
//             ? []
//             : List<Merge>.from(json["personal"]!.map((x) => Merge.fromJson(x))),
//         merge: json["merge"] == null
//             ? []
//             : List<Merge>.from(json["merge"]!.map((x) => Merge.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "personal": personal == null
//             ? []
//             : List<dynamic>.from(personal!.map((x) => x.toJson())),
//         "merge": merge == null
//             ? []
//             : List<dynamic>.from(merge!.map((x) => x.toJson())),
//       };
// }

// class Merge {
//   int? id;
//   List<String>? productImage;
//   String? productName;
//   String? state;
//   String? lga;
//   String? description;
//   String? amount;
//   String? category;
//   String? sku;
//   String? status;
//   String? amountBuy;
//   List<String>? sellerImage;
//   bool? isApproved;
//   bool? isPublished;
//   bool? isPersonal;
//   bool? isMerge;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Merge({
//     this.id,
//     this.productImage,
//     this.productName,
//     this.state,
//     this.lga,
//     this.description,
//     this.amount,
//     this.category,
//     this.sku,
//     this.status,
//     this.isPersonal,
//     this.amountBuy,
//     this.sellerImage,
//     this.isApproved,
//     this.isPublished,
//     this.isMerge,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Merge.fromJson(Map<String, dynamic> json) => Merge(
//         id: json["id"],
//         productImage: json["productImage"] == null
//             ? []
//             : List<String>.from(json["productImage"]!.map((x) => x)),
//         productName: json["productName"],
//         state: json["state"],
//         lga: json["lga"],
//         description: json["description"],
//         amount: json["amount"],
//         category: json["category"],
//         sku: json["sku"],
//         isPersonal: json["isPersonal"] ?? true,
//         status: json["status"],
//         amountBuy: json["amountBuy"],
//         sellerImage: json["sellerImage"] == null
//             ? []
//             : List<String>.from(json["sellerImage"]!.map((x) => x)),
//         isApproved: json["isApproved"],
//         isPublished: json["isPublished"],
//         isMerge: json["isMerge"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "productImage": productImage == null
//             ? []
//             : List<dynamic>.from(productImage!.map((x) => x)),
//         "productName": productName,
//         "state": state,
//         "lga": lga,
//         "description": description,
//         "amount": amount,
//         "category": category,
//         "sku": sku,
//         "isPersonal": isPersonal,
//         "status": status,
//         "amountBuy": amountBuy,
//         "sellerImage": sellerImage == null
//             ? []
//             : List<dynamic>.from(sellerImage!.map((x) => x)),
//         "isApproved": isApproved,
//         "isPublished": isPublished,
//         "isMerge": isMerge,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
// }

// To parse this JSON data, do
//
//     final fetchPortfolioResponse = fetchPortfolioResponseFromJson(jsonString);

import 'dart:convert';

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
  List<Datum>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  int? id;
  List? productImage;
  String? productName;
  String? state;
  String? lga;
  String? description;
  String? category;
  String? amount;
  String? sku;
  String? status;
  dynamic amountBuy;
  bool? isPersonal;
  dynamic sellerImage;
  bool? isApproved;
  bool? isPublished;
  bool? isMerge;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
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
    this.isPersonal,
    this.sellerImage,
    this.isApproved,
    this.isPublished,
    this.isMerge,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productImage: json["productImage"].split(","),
        productName: json["productName"],
        state: json["state"],
        lga: json["lga"],
        description: json["description"],
        category: json["category"],
        amount: json["amount"],
        sku: json["sku"],
        status: json["status"],
        amountBuy: json["amountBuy"],
        isPersonal: json["isPersonal"],
        sellerImage: json["sellerImage"].split(","),
        isApproved: json["isApproved"],
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
        "isPersonal": isPersonal,
        "sellerImage": sellerImage,
        "isApproved": isApproved,
        "isPublished": isPublished,
        "isMerge": isMerge,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Pagination {
  int? total;
  int? totalPage;
  int? perPage;
  int? currentPageItemCount;
  int? currentPage;
  dynamic previousPage;
  String? nextPage;

  Pagination({
    this.total,
    this.totalPage,
    this.perPage,
    this.currentPageItemCount,
    this.currentPage,
    this.previousPage,
    this.nextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        totalPage: json["totalPage"],
        perPage: json["perPage"],
        currentPageItemCount: json["currentPageItemCount"],
        currentPage: json["currentPage"],
        previousPage: json["previousPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "totalPage": totalPage,
        "perPage": perPage,
        "currentPageItemCount": currentPageItemCount,
        "currentPage": currentPage,
        "previousPage": previousPage,
        "nextPage": nextPage,
      };
}
