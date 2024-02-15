// To parse this JSON data, do
//
//     final localNotificationModel = localNotificationModelFromJson(jsonString);

import 'dart:convert';

LocalNotificationModel localNotificationModelFromJson(String str) =>
    LocalNotificationModel.fromJson(json.decode(str));

String localNotificationModelToJson(LocalNotificationModel data) =>
    json.encode(data.toJson());

class LocalNotificationModel {
  int? count;
  List<Datum>? data;

  LocalNotificationModel({
    this.count,
    this.data,
  });

  factory LocalNotificationModel.fromJson(Map<String, dynamic> json) =>
      LocalNotificationModel(
        count: json["count"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? title;
  String? body;
  String? image;
  bool? isRead;
  int? hashedCode;
  int? date;
  bool? hasAction;

  Datum({
    this.title,
    this.body,
    this.image,
    this.isRead,
    this.hashedCode,
    this.date,
    this.hasAction,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        body: json["body"],
        image: json["image"],
        isRead: json["isRead"],
        hashedCode: json["hashedCode"],
        date: json["date"],
        hasAction: json["hasAction"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "image": image,
        "isRead": isRead,
        "hashedCode": hashedCode,
        "date": date,
        "hasAction": hasAction,
      };
}
