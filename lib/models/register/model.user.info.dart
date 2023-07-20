// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String? token;
  String? email;
  String? fullName;
  String? phoneNumber;
  dynamic phoneNumber2;
  String? accountName;
  String? accountNumber;
  String? profileImageUrl;
  dynamic cacUrl;
  String? governmentIdImageUrl;
  dynamic letterHeadImageUrl;
  String? address;
  String? state;
  String? lga;
  String? companyName;
  String? bankName;
  String? govId;
  String? ownVehicle;
  String? financialCapacity;
  String? id;
  String? refreshToken;
  int? createdAt;
  int? updatedAt;
  dynamic investorSignature;
  bool? isVerifiedEmail;
  bool? isLive;
  bool? isBlock;
  bool? isAdmin;
  bool? isMerge;
  List? kfi;

  UserDataModel({
    this.token,
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
    this.id,
    this.refreshToken,
    this.createdAt,
    this.updatedAt,
    this.investorSignature,
    this.isVerifiedEmail,
    this.isLive,
    this.isBlock,
    this.isAdmin,
    this.isMerge,
    this.kfi,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        token: json["token"],
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
        bankName: json["bankName"],
        companyName: json["companyName"],
        govId: json["govId"],
        ownVehicle: json["ownVehicle"],
        financialCapacity: json["financialCapacity"],
        id: json["id"],
        refreshToken: json["refreshToken"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        investorSignature: json["investorSignature"],
        isVerifiedEmail: json["isVerifiedEmail"],
        isLive: json["isLive"],
        isBlock: json["isBlock"],
        isAdmin: json["isAdmin"],
        isMerge: json["isMerge"],
        kfi: json["kfi"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
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
        "id": id,
        "refreshToken": refreshToken,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "investorSignature": investorSignature,
        "isVerifiedEmail": isVerifiedEmail,
        "isLive": isLive,
        "isBlock": isBlock,
        "isAdmin": isAdmin,
        "isMerge": isMerge,
        "kfi": kfi,
      };
}
