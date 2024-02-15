// To parse this JSON data, do
//
//     final notificationResposeDataModel = notificationResposeDataModelFromJson(jsonString);

import 'dart:convert';

NotificationResposeDataModel notificationResposeDataModelFromJson(String str) =>
    NotificationResposeDataModel.fromJson(json.decode(str));

String notificationResposeDataModelToJson(NotificationResposeDataModel data) =>
    json.encode(data.toJson());

class NotificationResposeDataModel {
  dynamic extra;
  String? notificationType;
  String? body;
  String? title;
  String? image;
  String? channelId;

  NotificationResposeDataModel({
    this.extra,
    this.notificationType,
    this.body,
    this.title,
    this.image,
    this.channelId,
  });

  factory NotificationResposeDataModel.fromJson(Map<String, dynamic> json) =>
      NotificationResposeDataModel(
        extra: json["extra"],
        notificationType: json["notificationType"],
        body: json["body"],
        title: json["title"],
        image: json["image"],
        channelId: json["channel_id"],
      );

  Map<String, dynamic> toJson() => {
        "extra": extra,
        "notificationType": notificationType,
        "body": body,
        "image": image,
        "title": title,
        "channel_id": channelId,
      };
}
