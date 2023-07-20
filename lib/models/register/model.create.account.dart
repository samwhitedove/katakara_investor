// To parse this JSON data, do
//
//     final createAccountModel = createAccountModelFromJson(jsonString);

import 'dart:convert';

CreateAccountModel createAccountModelFromJson(String str) =>
    CreateAccountModel.fromJson(json.decode(str));

String createAccountModelToJson(CreateAccountModel data) =>
    json.encode(data.toJson());

class CreateAccountModel {
  final String? email;
  final String? password;
  final String? fullName;
  final String? phoneNumber;
  final String? phoneNumber2;
  final String? accountName;
  final String? accountNumber;
  final String? profileImageUrl;
  final String? cacUrl;
  final String? governmentIdImageUrl;
  final String? letterHeadImageUrl;
  final String? address;
  final String? state;
  final String? companyName;
  final String? lga;
  final String? bankName;
  final String? govId;
  final String? ownVehicle;
  final String? financialCapacity;
  final String? code;

  CreateAccountModel({
    this.email,
    this.password,
    this.fullName,
    this.phoneNumber,
    this.phoneNumber2,
    this.accountName,
    this.accountNumber,
    this.profileImageUrl,
    this.cacUrl,
    this.companyName,
    this.governmentIdImageUrl,
    this.letterHeadImageUrl,
    this.address,
    this.state,
    this.lga,
    this.bankName,
    this.govId,
    this.ownVehicle,
    this.financialCapacity,
    this.code,
  });

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) =>
      CreateAccountModel(
        email: json["email"],
        password: json["password"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        phoneNumber2: json["phoneNumber2"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        profileImageUrl: json["profileImageUrl"],
        cacUrl: json["cacUrl"],
        companyName: json["companyName"],
        governmentIdImageUrl: json["governmentIdImageUrl"],
        letterHeadImageUrl: json["letterHeadImageUrl"],
        address: json["address"],
        state: json["state"],
        lga: json["lga"],
        bankName: json["bankName"],
        govId: json["govId"],
        ownVehicle: json["ownVehicle"],
        financialCapacity: json["financialCapacity"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "phoneNumber2": phoneNumber2,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "profileImageUrl": profileImageUrl,
        "cacUrl": cacUrl,
        "companyName": companyName,
        "governmentIdImageUrl": governmentIdImageUrl,
        "letterHeadImageUrl": letterHeadImageUrl,
        "address": address,
        "state": state,
        "lga": lga,
        "bankName": bankName,
        "govId": govId,
        "ownVehicle": ownVehicle,
        "financialCapacity": financialCapacity,
        "code": code,
      };
}
