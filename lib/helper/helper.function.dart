import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.auth.dart';

import '../values/values.dart';

class HC {
  static final HC _singleton = HC._internal();
  static dynamic _fcm;

  factory HC() {
    return _singleton;
  }

  HC._internal();

  static Future<RequestResponseModel> mockFailedResponse() async {
    return await Get.find<AuthService>().mockFailedResponse();
  }

  static mockUnathorizedResponse() async {
    await Future.delayed(CW.onesSec);
    return dio.DioException.badResponse(
        statusCode: 401,
        requestOptions: dio.RequestOptions(),
        response: dio.Response(requestOptions: dio.RequestOptions()));
  }

  static Future<RequestResponseModel> mockSuccesResponse(dynamic data) async {
    return await Get.find<AuthService>().mockSuccessResponse(data: data);
  }

  static successMessage({String? message, Map<String, dynamic>? data}) => {
        'message': message ?? "Data saved successful",
        'status': true,
        "data": data,
      };

  static failedMessage({String? message}) =>
      {'message': message ?? "process failed", 'status': false};

  static bool validateEmail(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  static double calculateHeight(double h) {
    if (h > 0) {
      double designHeight = 926;
      double calPerc = (h / designHeight) * 100;
      double originalPerc = (calPerc / 100) * Get.height;
      return originalPerc;
    }

    return h;
  }

  static double calculateWidth(double w) {
    if (w > 0) {
      double designWidth = 428;
      double calPerc = (w / designWidth) * 100;
      double originalPerc = (calPerc / 100) * Get.width;
      return originalPerc;
    }

    return w;
  }

  static double spaceHorizontal(x) {
    return calculateWidth(x.toDouble());
  }

  static double spaceVertical(x) {
    return calculateHeight(x.toDouble());
  }

  static Map<String, dynamic> validatePasswordStrength(String text) {
    bool hasUppercase = text.contains(RegExp(r'[A-Z]'));
    bool hasDigits = text.contains(RegExp(r'[0-9]'));
    bool hasLowercase = text.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = text.length > 8;

    if (!hasUppercase) {
      return {"message": "Must contain one capital letter", "status": false};
    }
    if (!hasDigits) {
      return {"message": "Must contain one number", "status": false};
    }
    if (!hasLowercase) {
      return {"message": "Must contain one small letter", "status": false};
    }
    if (!hasSpecialCharacters) {
      return {
        "message": "Must have one special character e.g !, @, #, \$, %",
        "status": false
      };
    }
    if (!hasMinLength) {
      return {"message": "Must be eight(8) character long", "status": false};
    }

    if (text.trim().contains(" ")) {
      return {"message": "Must not contain spaces", "status": false};
    }

    return {
      "message": null,
      "status": true,
    };
  }

  static snack(message, {bool success = false}) {
    ScaffoldMessenger.of(Get.context!).removeCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: success ? AppColor.primary : AppColor.red,
    ));
  }

  static void hideKeyBoard() {
    Get.focusScope?.unfocus();
  }

  static Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  static Future<Map<String, dynamic>> pickAndCheckImage(
      ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage == null) return {'hasImage': false, 'image': pickedImage};
    final image = File(pickedImage.path);
    int imageSize = await image.stat().then((value) => value.size);
    if (imageSize > 5000000) {
      HC.snack("File too large to upload, must be more than 5MB");
      return {'hasImage': false, 'image': pickedImage};
    }
    String mimitype =
        pickedImage.path.split('/').last.split('.').last.toLowerCase();

    return {'hasImage': true, 'image': image, 'mime': mimitype};
  }

  static Future<File> cropImage(File imageFile,
      {List<CropType> crop = const [CropType.ratio3x2]}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        if (crop.contains(CropType.square)) CropAspectRatioPreset.square,
        if (crop.contains(CropType.ratio3x2)) CropAspectRatioPreset.ratio3x2,
        if (crop.contains(CropType.original)) CropAspectRatioPreset.original,
        if (crop.contains(CropType.ratio4x3)) CropAspectRatioPreset.ratio4x3,
        if (crop.contains(CropType.ratio16x9)) CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColor.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio3x2,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
          aspectRatioLockDimensionSwapEnabled: true,
        ),
      ],
    );
    log('$croppedFile------ path cropper image');
    if (croppedFile == null) return File("");
    return File(croppedFile.path);
  }

  static void clearImages(List<String> images) async {
    for (String downloadUrl in images) {
      await Get.find<AuthService>().deleteImage(downloadUrl);
    }
  }

  static File resizeImage(Uint8List image, {Size? size}) {
    img.Image? uiImage = img.decodeImage(image);
    img.Image resized = img.copyResize(uiImage!,
        width: size?.width.toInt() ?? 200, height: size?.height.toInt() ?? 200);
    Uint8List resizedImg = Uint8List.fromList(img.encodePng(resized));
    return resizedImg.first as File;
  }

  static FirebaseMessaging initFCM() {
    if (_fcm != null) return _fcm;
    _fcm = FirebaseMessaging.instance;
    return _fcm;
  }

  static String formatDate(DateTime date, {bool formatSimple = false}) {
    if (formatSimple) {
      return '${DateFormat.yMd().format(date)} - ${DateFormat.jm().format(date)}';
    }
    return '${DateFormat.yMMMEd().format(date)} - ${DateFormat.jm().format(date)}';
  }

  static String formartValue(dynamic value) {
    log(value.toString());
    log(value.runtimeType.toString());
    if (value.runtimeType == bool) return value ? "Yes" : "No";
    if (value.runtimeType == int) return value.toString();
    if (value.runtimeType == Null) return "Unavailable";
    if (value.toString().contains('-')) {
      final parseDate = DateTime.tryParse(value.toString());
      if (parseDate == null) return value;
      return HC.formatDate(parseDate);
    }
    return value.toString();
  }

  static Color handleStatusView(String status) {
    switch (status) {
      case "PENDING":
        return AppColor.grey;
      case "APPROVED":
        return AppColor.primary;
      case "REJECTED":
        return AppColor.red;
      default:
        return AppColor.grey;
    }
  }
}
