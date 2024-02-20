// To parse this JSON data, do
//
//     final notificationResposeModel = notificationResposeModelFromJson(jsonString);

import 'dart:convert';

NotificationResposeModel notificationResposeModelFromJson(String str) =>
    NotificationResposeModel.fromJson(json.decode(str));

String notificationResposeModelToJson(NotificationResposeModel data) =>
    json.encode(data.toJson());

class NotificationResposeModel {
  String? actionType;
  bool? autoDismissible;
  int? backgroundColor;
  dynamic bigPicture;
  String? body;
  dynamic category;
  String? channelKey;
  dynamic chronometer;
  int? color;
  DateTime? createdDate;
  String? createdLifeCycle;
  String? createdSource;
  bool? criticalAlert;
  dynamic customSound;
  DateTime? displayedDate;
  String? displayedLifeCycle;
  bool? fullScreenIntent;
  String? groupKey;
  dynamic icon;
  int? id;
  dynamic largeIcon;
  dynamic payload;
  dynamic privacy;
  bool? roundedBigPicture;
  bool? roundedLargeIcon;
  bool? showWhen;
  dynamic summary;
  dynamic timeoutAfter;
  String? title;
  String? notificationType;
  String? image;
  bool? wakeUpScreen;

  NotificationResposeModel({
    this.actionType,
    this.autoDismissible,
    this.backgroundColor,
    this.bigPicture,
    this.body,
    this.category,
    this.channelKey,
    this.chronometer,
    this.color,
    this.createdDate,
    this.createdLifeCycle,
    this.createdSource,
    this.criticalAlert,
    this.customSound,
    this.displayedDate,
    this.displayedLifeCycle,
    this.fullScreenIntent,
    this.groupKey,
    this.icon,
    this.id,
    this.largeIcon,
    this.payload,
    this.privacy,
    this.roundedBigPicture,
    this.roundedLargeIcon,
    this.showWhen,
    this.summary,
    this.timeoutAfter,
    this.title,
    this.notificationType,
    this.image,
    this.wakeUpScreen,
  });

  factory NotificationResposeModel.fromJson(Map<String, dynamic> json) =>
      NotificationResposeModel(
        actionType: json["actionType"],
        autoDismissible: json["autoDismissible"],
        backgroundColor: json["backgroundColor"],
        bigPicture: json["bigPicture"],
        body: json["body"],
        category: json["category"],
        channelKey: json["channelKey"],
        chronometer: json["chronometer"],
        color: json["color"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        createdLifeCycle: json["createdLifeCycle"],
        createdSource: json["createdSource"],
        criticalAlert: json["criticalAlert"],
        customSound: json["customSound"],
        displayedDate: json["displayedDate"] == null
            ? null
            : DateTime.parse(json["displayedDate"]),
        displayedLifeCycle: json["displayedLifeCycle"],
        fullScreenIntent: json["fullScreenIntent"],
        groupKey: json["groupKey"],
        icon: json["icon"],
        id: json["id"],
        largeIcon: json["largeIcon"],
        payload: json["payload"],
        privacy: json["privacy"],
        roundedBigPicture: json["roundedBigPicture"],
        roundedLargeIcon: json["roundedLargeIcon"],
        showWhen: json["showWhen"],
        summary: json["summary"],
        timeoutAfter: json["timeoutAfter"],
        title: json["title"],
        notificationType: json["notificationType"],
        image: json["image"],
        wakeUpScreen: json["wakeUpScreen"],
      );

  Map<String, dynamic> toJson() => {
        "actionType": actionType,
        "autoDismissible": autoDismissible,
        "backgroundColor": backgroundColor,
        "bigPicture": bigPicture,
        "body": body,
        "category": category,
        "channelKey": channelKey,
        "chronometer": chronometer,
        "color": color,
        "createdDate": createdDate?.toIso8601String(),
        "createdLifeCycle": createdLifeCycle,
        "createdSource": createdSource,
        "criticalAlert": criticalAlert,
        "customSound": customSound,
        "displayedDate": displayedDate?.toIso8601String(),
        "displayedLifeCycle": displayedLifeCycle,
        "fullScreenIntent": fullScreenIntent,
        "groupKey": groupKey,
        "icon": icon,
        "id": id,
        "notificationType": notificationType,
        "image": image,
        "largeIcon": largeIcon,
        "payload": payload,
        "privacy": privacy,
        "roundedBigPicture": roundedBigPicture,
        "roundedLargeIcon": roundedLargeIcon,
        "showWhen": showWhen,
        "summary": summary,
        "timeoutAfter": timeoutAfter,
        "title": title,
        "wakeUpScreen": wakeUpScreen,
      };
}
