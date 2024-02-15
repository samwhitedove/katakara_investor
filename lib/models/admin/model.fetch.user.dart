// To parse this JSON data, do
//
//     final fetchAllUser = fetchAllUserFromJson(jsonString);

import 'dart:convert';

import '../receipt/model.fetch.reponse.dart';

FetchAllUser fetchAllUserFromJson(String str) =>
    FetchAllUser.fromJson(json.decode(str));

String fetchAllUserToJson(FetchAllUser data) => json.encode(data.toJson());

class FetchAllUser {
  List<FetchedUser>? data;
  Pagination? pagination;

  FetchAllUser({
    this.data,
    this.pagination,
  });

  factory FetchAllUser.fromJson(Map<String, dynamic> json) => FetchAllUser(
        data: json["data"] == null
            ? []
            : List<FetchedUser>.from(
                json["data"]!.map((x) => FetchedUser.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "fetched": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class FetchedUser {
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
  bool? isLive;
  bool? isBlock;
  bool? isMerge;
  String? role;

  FetchedUser({
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
    this.isLive,
    this.isBlock,
    this.isMerge,
    this.role,
  });

  factory FetchedUser.fromJson(Map<String, dynamic> json) => FetchedUser(
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
        isLive: json["isLive"],
        isBlock: json["isBlock"],
        isMerge: json["isMerge"],
        role: json["role"],
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
        "isLive": isLive,
        "isBlock": isBlock,
        "isMerge": isMerge,
        "role": role,
      };
}
