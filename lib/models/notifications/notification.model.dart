// To parse this JSON data, do
//
//     final notificationAlertModel = notificationAlertModelFromJson(jsonString);

import 'dart:convert';

NotificationAlertModel notificationAlertModelFromJson(String str) =>
    NotificationAlertModel.fromJson(json.decode(str));

String notificationAlertModelToJson(NotificationAlertModel data) =>
    json.encode(data.toJson());

class NotificationAlertModel {
  String? title;
  String? body;
  String? image;
  int? hashedCode;
  bool? isRead;
  DateTime? date;
  bool? hasAction;

  NotificationAlertModel({
    this.title,
    this.body,
    this.image,
    this.isRead,
    this.date,
    this.hashedCode,
    this.hasAction,
  });

  factory NotificationAlertModel.fromJson(Map<String, dynamic> json) =>
      NotificationAlertModel(
        title: json["title"],
        body: json["body"],
        image: json["image"],
        isRead: json["isRead"] ?? false,
        date: json["date"],
        hashedCode: json["hashedCode"],
        hasAction: json["hasAction"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "image": image,
        "isRead": isRead,
        "hashedCode": hashedCode,
        "date": date!.millisecondsSinceEpoch,
        "hasAction": hasAction,
      };

  NotificationAlertModel toClassObject(Map<String, dynamic> data) =>
      NotificationAlertModel(
          body: data['body'],
          date: DateTime.fromMillisecondsSinceEpoch(data['date']),
          title: data['title'],
          hasAction: data['hasAction'],
          image: data['image'],
          hashedCode: data['hashedCode'],
          isRead: data['isRead']);
}
