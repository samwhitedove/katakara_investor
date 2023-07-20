import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../values/values.dart';

class HC {
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

  static double spaceHorizontal(x) {
    return Get.width * ((x / Get.width) * 100) / 100;
  }

  static double spaceVertical(x) {
    return Get.height * ((x / Get.height) * 100) / 100;
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

  static cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        // CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
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
    log(croppedFile.toString() + '------ path cropper image');
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }
}
