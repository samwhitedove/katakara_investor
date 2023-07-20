// To parse this JSON data, do
//
//     final httpResponsModel = httpResponsModelFromJson(jsonString);

import 'dart:convert';

RequestResponsModel httpResponsModelFromJson(String str) =>
    RequestResponsModel.fromJson(json.decode(str));

String httpResponsModelToJson(RequestResponsModel data) =>
    json.encode(data.toJson());

class RequestResponsModel {
  final int? statusCode;
  final String? message;
  final bool success;
  final dynamic data;

  RequestResponsModel({
    this.statusCode,
    this.message,
    this.success = false,
    this.data,
  });

  factory RequestResponsModel.fromJson(Map<String, dynamic> json) =>
      RequestResponsModel(
        statusCode: json["statusCode"] ?? 500,
        message: json["message"],
        success: json["success"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "success": success,
        "data": data,
      };
}
