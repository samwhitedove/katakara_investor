import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class ProfileService extends GetxController {
  Future<RequestResponseModel> updateImagesAndDocs(
      {dynamic controller,
      required File pickedImage,
      required String fieldToUpdate,
      required String? previousUrl,
      shouldUpdateLocal = true}) async {
    final String mimitype =
        pickedImage.path.split('/').last.split('.').last.toLowerCase();
    RequestResponseModel response = await MyRequestClass.uploadImage(
        filePath: pickedImage,
        fileType: mimitype == 'pdf' ? ImageType.PDF : ImageType.IMAGE,
        controller: controller);
    if (response.success && shouldUpdateLocal) {
      final resp =
          await updateUserInformation(data: {fieldToUpdate: response.data});
      if (!resp.success) {
        if (previousUrl != null) {
          deleteImage(
              fieldToUpdate: fieldToUpdate,
              updateInfo: false,
              url: previousUrl);
          AppSettings.removeUploadeImageUrlFromStorage(value: response.data);
        }
      }
    }
    return response;
  }

  Future<RequestResponseModel> deleteImage(
      {String? url,
      required String fieldToUpdate,
      bool updateInfo = true}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
      endPoint: EndPoint.deleteImage,
      method: Methods.delete,
      body: {"url": url},
    );
    // setting the field to empty string in the database
    if (updateInfo) await updateUserInformation(data: {fieldToUpdate: "Null"});
    if (response.success) {
      AppSettings.updateLocalUserData({fieldToUpdate: response.data});
    }
    return response;
  }

  Future<RequestResponseModel> updateUserInformation(
      {required Map<String, dynamic> data}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.updateProfile, body: data, method: Methods.patch);
    log("Updating user info ------- ${response.message}");
    if (data.containsKey('ownVehicle')) {
      data['ownVehicle'] = (data['ownVehicle'] == "Yes");
    }
    AppSettings.updateLocalUserData(data);
    return response;
  }

  Future<RequestResponseModel> changePassword(
      {required Map<String, dynamic> data}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
      endPoint: EndPoint.changeUserPassword,
      body: data,
      method: Methods.patch,
    );
    log("Updating user info ------- ${response.message}");
    return response;
  }
}
