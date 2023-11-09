// To parse this JSON data, do
//
//     final selectImageModel = selectImageModelFromJson(jsonString);

import 'dart:convert';

SelectImageModel selectImageModelFromJson(String str) =>
    SelectImageModel.fromJson(json.decode(str));

String selectImageModelToJson(SelectImageModel data) =>
    json.encode(data.toJson());

class SelectImageModel {
  String? path;
  bool? isLoading;
  bool? isUploaded;
  int? id;

  SelectImageModel({
    this.path,
    this.isLoading,
    this.isUploaded,
    this.id,
  });

  factory SelectImageModel.fromJson(Map<String, dynamic> json) =>
      SelectImageModel(
        path: json["path"],
        id: json["id"],
        isLoading: json["isLoading"],
        isUploaded: json["isUploaded"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "id": id,
        "isLoading": isLoading,
        "isUploaded": isUploaded,
      };
}
