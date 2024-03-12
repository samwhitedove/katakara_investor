// To parse this JSON data, do
//
//     final chatData = chatDataFromJson(jsonString);

import 'dart:convert';

ChatMessages chatDataFromJson(String str) =>
    ChatMessages.fromJson(json.decode(str));

String chatDataToJson(ChatMessages data) => json.encode(data.toJson());

class ChatMapData {
  String lastMessage;
  String senderUuid;
  String senderName;
  String? profileImage;
  int totalUnread;
  int totalMessages;
  List<ChatMessages> messages;

  ChatMapData({
    required this.lastMessage,
    required this.senderUuid,
    required this.totalUnread,
    required this.totalMessages,
    required this.profileImage,
    required this.senderName,
    required this.messages,
  });

  factory ChatMapData.fromJson(Map<String, dynamic> json) => ChatMapData(
        lastMessage: json["lastMessage"],
        senderUuid: json['senderUuid'],
        senderName: json['senderName'],
        profileImage: json['profileImage'],
        totalUnread: json['totalUnread'],
        totalMessages: json['totalMessaged'],
        messages: json['messages'],
      );

  Map<String, dynamic> toJson() => {
        "lastMessage": lastMessage,
        "senderUuid": senderUuid,
        "totalUnread": totalUnread,
        "senderName": senderName,
        "profileImage": profileImage,
        "totalMessaged": totalMessages,
        "messages": messages,
      };
}

class ChatMessages {
  String? senderUuid;
  String? message;
  String? replyMessage;
  String? messageId;
  bool? delivered;
  String? receiverUuid;
  String? imageUrl;
  String? audioUrl;
  String? file;
  String? date;
  String? profileImage;
  String? senderName;

  ChatMessages({
    this.senderUuid,
    this.message,
    this.replyMessage,
    this.messageId,
    this.delivered,
    this.receiverUuid,
    this.imageUrl,
    this.audioUrl,
    this.file,
    required this.profileImage,
    this.date,
    this.senderName,
  });

  factory ChatMessages.fromJson(Map<String, dynamic> json) => ChatMessages(
        senderUuid: json["senderUuid"],
        message: json["message"],
        replyMessage: json["replyMessage"],
        messageId: json["messageId"],
        delivered: json["delivered"],
        receiverUuid: json["receiverUuid"],
        imageUrl: json["imageUrl"],
        audioUrl: json["audioUrl"],
        file: json["file"],
        date: json["date"],
        profileImage: json['profileImage'],
        senderName: json["senderName"],
      );

  Map<String, dynamic> toJson() => {
        "senderUuid": senderUuid,
        "message": message,
        "replyMessage": replyMessage,
        "messageId": messageId,
        "delivered": delivered,
        "receiverUuid": receiverUuid,
        "imageUrl": imageUrl,
        "audioUrl": audioUrl,
        "file": file,
        "date": date,
        "profileImage": profileImage,
        "senderName": senderName,
      };
}

class ChatScreenDataPayload {
  String senderUuid;
  String senderName;
  String? profileImage;
  List<ChatMessages> messages;

  ChatScreenDataPayload({
    required this.senderUuid,
    required this.senderName,
    required this.messages,
    required this.profileImage,
  });

  factory ChatScreenDataPayload.fromJson(Map<String, dynamic> json) =>
      ChatScreenDataPayload(
        senderUuid: json['senderUuid'],
        senderName: json['senderName'],
        messages: json['messages'],
        profileImage: json['profileImage'],
      );

  Map<String, dynamic> toJson() => {
        "senderUuid": senderUuid,
        "senderName": senderName,
        "messages": messages,
        "profileImage": profileImage,
      };
}
