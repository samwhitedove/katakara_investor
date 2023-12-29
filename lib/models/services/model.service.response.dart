// To parse this JSON data, do
//
//     final httpResponsModel = httpResponsModelFromJson(jsonString);

import 'dart:convert';

RequestResponseModel httpResponsModelFromJson(String str) =>
    RequestResponseModel.fromJson(json.decode(str));

String httpResponsModelToJson(RequestResponseModel data) =>
    json.encode(data.toJson());

class RequestResponseModel {
  final int? statusCode;
  final String? message;
  final bool success;
  late final dynamic data;

  RequestResponseModel({
    this.statusCode,
    this.message,
    this.success = false,
    this.data,
  });

  factory RequestResponseModel.fromJson(Map<String, dynamic> json) =>
      RequestResponseModel(
        statusCode: json["statusCode"] ?? 500,
        message: json["message"],
        success: json["success"] ?? false,
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "success": success,
        "data": data,
      };
}
