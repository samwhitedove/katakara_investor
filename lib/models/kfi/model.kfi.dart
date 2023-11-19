// To parse this JSON data, do
//
//     final fetchMergeResponse = fetchMergeResponseFromJson(jsonString);

import 'dart:convert';

FetchMergeResponse fetchMergeResponseFromJson(String str) =>
    FetchMergeResponse.fromJson(json.decode(str));

String fetchMergeResponseToJson(FetchMergeResponse data) =>
    json.encode(data.toJson());

class FetchMergeResponse {
  String? message;
  int? statusCode;
  List<MergeUsers>? data;
  bool? success;

  FetchMergeResponse({
    this.message,
    this.statusCode,
    this.data,
    this.success,
  });

  factory FetchMergeResponse.fromJson(Map<String, dynamic> json) =>
      FetchMergeResponse(
        message: json["message"],
        statusCode: json["statusCode"],
        data: json["data"] == null
            ? []
            : List<MergeUsers>.from(
                json["data"]!.map((x) => MergeUsers.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}

class MergeUsers {
  String? fullName;
  String? phoneNumber;
  String? email;
  String? state;
  String? lga;
  String? address;
  bool? ownVehicle;
  String? uuid;
  String? profileImage;
  bool? isMerge;

  MergeUsers({
    this.fullName,
    this.phoneNumber,
    this.email,
    this.state,
    this.lga,
    this.address,
    this.ownVehicle,
    this.uuid,
    this.profileImage,
    this.isMerge,
  });

  factory MergeUsers.fromJson(Map<String, dynamic> json) => MergeUsers(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        state: json["state"],
        lga: json["lga"],
        address: json["address"],
        ownVehicle: json["ownVehicle"],
        uuid: json["uuid"],
        profileImage: json["profileImage"],
        isMerge: json["isMerge"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "state": state,
        "lga": lga,
        "address": address,
        "ownVehicle": ownVehicle,
        "uuid": uuid,
        "profileImage": profileImage,
        "isMerge": isMerge,
      };
}
