// To parse this JSON data, do
//
//     final receiptItemData = receiptItemDataFromJson(jsonString);

import 'dart:convert';

ReceiptItemData receiptItemDataFromJson(String str) =>
    ReceiptItemData.fromJson(json.decode(str));

String receiptItemDataToJson(ReceiptItemData data) =>
    json.encode(data.toJson());

class ReceiptItemData {
  String? itemName;
  String? price;
  String? quantity;
  String? description;

  ReceiptItemData({
    this.itemName,
    this.price,
    this.quantity,
    this.description,
  });

  factory ReceiptItemData.fromJson(Map<String, dynamic> json) =>
      ReceiptItemData(
        itemName: json["itemName"],
        price: json["price"],
        quantity: json["quantity"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "price": price,
        "quantity": quantity,
        "description": description,
      };
}
