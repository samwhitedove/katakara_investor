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
  List<FetchedReceipt>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<FetchedReceipt>.from(
                json["data"]!.map((x) => FetchedReceipt.fromJson(x))),
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

class FetchedReceipt {
  int? id;
  String? customerName;
  String? customerAddress;
  String? totalAmount;
  String? status;
  String? receiptCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  List<ReceiptProductInfo>? receiptProductInfo;

  FetchedReceipt({
    this.id,
    this.customerName,
    this.customerAddress,
    this.totalAmount,
    this.status,
    this.receiptCode,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.receiptProductInfo,
  });

  factory FetchedReceipt.fromJson(Map<String, dynamic> json) => FetchedReceipt(
        id: json["id"],
        customerName: json["customerName"],
        customerAddress: json["customerAddress"],
        totalAmount: json["totalAmount"],
        status: json["status"],
        receiptCode: json["receiptCode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        "status": status,
        "receiptCode": receiptCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
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

class User {
  int? id;
  DateTime? createdAt;
  DateTime? updateAt;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? phoneNumber2;
  String? accountName;
  String? accountNumber;
  dynamic profileImageUrl;
  dynamic cacUrl;
  dynamic governmentIdImageUrl;
  dynamic letterHeadImageUrl;
  String? address;
  String? state;
  String? lga;
  String? companyName;
  String? bankName;
  dynamic govId;
  bool? ownVehicle;
  String? financialCapacity;
  String? uuid;
  int? mergeCount;
  bool? isLive;
  bool? isBlock;
  String? role;
  bool? isMerge;

  User({
    this.id,
    this.createdAt,
    this.updateAt,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.phoneNumber2,
    this.accountName,
    this.accountNumber,
    this.profileImageUrl,
    this.cacUrl,
    this.governmentIdImageUrl,
    this.letterHeadImageUrl,
    this.address,
    this.state,
    this.lga,
    this.companyName,
    this.bankName,
    this.govId,
    this.ownVehicle,
    this.financialCapacity,
    this.uuid,
    this.mergeCount,
    this.isLive,
    this.isBlock,
    this.role,
    this.isMerge,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updateAt:
            json["updateAt"] == null ? null : DateTime.parse(json["updateAt"]),
        email: json["email"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        phoneNumber2: json["phoneNumber2"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        profileImageUrl: json["profileImageUrl"],
        cacUrl: json["cacUrl"],
        governmentIdImageUrl: json["governmentIdImageUrl"],
        letterHeadImageUrl: json["letterHeadImageUrl"],
        address: json["address"],
        state: json["state"],
        lga: json["lga"],
        companyName: json["companyName"],
        bankName: json["bankName"],
        govId: json["govId"],
        ownVehicle: json["ownVehicle"],
        financialCapacity: json["financialCapacity"],
        uuid: json["uuid"],
        mergeCount: json["mergeCount"],
        isLive: json["isLive"],
        isBlock: json["isBlock"],
        role: json["role"],
        isMerge: json["isMerge"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updateAt": updateAt?.toIso8601String(),
        "email": email,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "phoneNumber2": phoneNumber2,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "profileImageUrl": profileImageUrl,
        "cacUrl": cacUrl,
        "governmentIdImageUrl": governmentIdImageUrl,
        "letterHeadImageUrl": letterHeadImageUrl,
        "address": address,
        "state": state,
        "lga": lga,
        "companyName": companyName,
        "bankName": bankName,
        "govId": govId,
        "ownVehicle": ownVehicle,
        "financialCapacity": financialCapacity,
        "uuid": uuid,
        "mergeCount": mergeCount,
        "isLive": isLive,
        "isBlock": isBlock,
        "role": role,
        "isMerge": isMerge,
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
