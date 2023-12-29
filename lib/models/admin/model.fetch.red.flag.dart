// To parse this JSON data, do
//
//     final fetchRedFlag = fetchRedFlagFromJson(jsonString);

import 'dart:convert';

import 'package:katakara_investor/models/product/models.fetch.portfolio.response.dart';

FetchRedFlag fetchRedFlagFromJson(String str) =>
    FetchRedFlag.fromJson(json.decode(str));

String fetchRedFlagToJson(FetchRedFlag data) => json.encode(data.toJson());

class FetchRedFlag {
  String? message;
  int? statusCode;
  Data? data;
  bool? success;

  FetchRedFlag({
    this.message,
    this.statusCode,
    this.data,
    this.success,
  });

  factory FetchRedFlag.fromJson(Map<String, dynamic> json) => FetchRedFlag(
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
  List<RedFlags>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<RedFlags>.from(
                json["data"]!.map((x) => RedFlags.fromJson(x))),
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

class RedFlags {
  int? id;
  String? title;
  String? message;
  String? subject;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  RedFlags({
    this.id,
    this.title,
    this.message,
    this.subject,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory RedFlags.fromJson(Map<String, dynamic> json) => RedFlags(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        subject: json["subject"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "subject": subject,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
