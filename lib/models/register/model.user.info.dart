import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  int? id;
  DateTime? createdAt;
  DateTime? updateAt;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? phoneNumber2;
  String? accountName;
  String? accountNumber;
  dynamic profileImageUrl;
  dynamic cacUrl;
  dynamic governmentIdImageUrl;
  dynamic letterHeadImageUrl;
  String? address;
  String? state;
  String? lga;
  String? companyName;
  String? bankName;
  dynamic govId;
  String? ownVehicle;
  String? financialCapacity;
  String? token;
  String? refreshToken;
  String? uuid;
  int? mergeCount;
  dynamic fcmToken;
  dynamic investorSignature;
  bool? isLive;
  bool? isBlock;
  String? role;
  bool? isMerge;

  UserDataModel({
    this.id,
    this.createdAt,
    this.updateAt,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.phoneNumber2,
    this.accountName,
    this.accountNumber,
    this.profileImageUrl,
    this.cacUrl,
    this.governmentIdImageUrl,
    this.letterHeadImageUrl,
    this.address,
    this.state,
    this.lga,
    this.companyName,
    this.bankName,
    this.govId,
    this.ownVehicle,
    this.financialCapacity,
    this.token,
    this.refreshToken,
    this.uuid,
    this.mergeCount,
    this.fcmToken,
    this.investorSignature,
    this.isLive,
    this.isBlock,
    this.role,
    this.isMerge,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updateAt:
            json["updateAt"] == null ? null : DateTime.parse(json["updateAt"]),
        email: json["email"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        phoneNumber2: json["phoneNumber2"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        profileImageUrl: json["profileImageUrl"],
        cacUrl: json["cacUrl"],
        governmentIdImageUrl: json["governmentIdImageUrl"],
        letterHeadImageUrl: json["letterHeadImageUrl"],
        address: json["address"],
        state: json["state"],
        lga: json["lga"],
        companyName: json["companyName"],
        bankName: json["bankName"],
        govId: json["govId"],
        ownVehicle: json["ownVehicle"].runtimeType == bool
            ? json["ownVehicle"]
                ? "Yes"
                : "No"
            : json["ownVehicle"],
        financialCapacity: json["financialCapacity"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        uuid: json["uuid"],
        mergeCount: json["mergeCount"],
        fcmToken: json["fcmToken"],
        investorSignature: json["investorSignature"],
        isLive: json["isLive"],
        isBlock: json["isBlock"],
        role: json["role"],
        isMerge: json["isMerge"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updateAt": updateAt?.toIso8601String(),
        "email": email,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "phoneNumber2": phoneNumber2,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "profileImageUrl": profileImageUrl,
        "cacUrl": cacUrl,
        "governmentIdImageUrl": governmentIdImageUrl,
        "letterHeadImageUrl": letterHeadImageUrl,
        "address": address,
        "state": state,
        "lga": lga,
        "companyName": companyName,
        "bankName": bankName,
        "govId": govId,
        "ownVehicle": ownVehicle,
        "financialCapacity": financialCapacity,
        "token": token,
        "refreshToken": refreshToken,
        "uuid": uuid,
        "mergeCount": mergeCount,
        "fcmToken": fcmToken,
        "investorSignature": investorSignature,
        "isLive": isLive,
        "isBlock": isBlock,
        "role": role,
        "isMerge": isMerge,
      };
}
