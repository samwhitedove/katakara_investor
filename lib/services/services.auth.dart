import 'dart:developer';

import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/models/register/register.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class AuthService extends GetxController {
  Future<RequestResponsModel> mockSuccessResponse({dynamic data}) async {
    return await Future.delayed(const Duration(seconds: 3)).then((value) {
      RequestResponsModel response = RequestResponsModel(
        data: data ?? [],
        message: "successful request",
        statusCode: 200,
        success: true,
      );
      return response;
    });
  }

  Future<RequestResponsModel> mockFailedResponse() async {
    return await Future.delayed(const Duration(seconds: 3)).then((value) {
      RequestResponsModel response = RequestResponsModel(
        data: null,
        message: "Failed request",
        statusCode: 400,
        success: false,
      );
      return response;
    });
  }

  Future<RequestResponsModel> fetchUser() async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUserInfo, method: Methods.get);
    log('${response.data} -----------fetch user');
    if (response.success && response.data != null) {
      AppSettings.saveUserToLocal(response.data);
    }
    return response;
  }

  // Future<RequestResponsModel> uploadImage(
  //     {required File pickedImage, required String mimitype, controller}) async {
  //   RequestResponsModel response = await MyRequestClass.uploadImage(
  //       filePath: pickedImage,
  //       // imageUploadType: type,
  //       fileType: mimitype == 'pdf' ? ImageType.PDF : ImageType.IMAGE,
  //       controller: controller);
  //   return response;
  // }

  Future<RequestResponsModel> deleteImage(String downloadUrl) async {
    final response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteImage,
        body: {"url": downloadUrl},
        method: Methods.delete);
    return response;
  }

  // void deleteAllLocalImage(List<String> downloadUrls) async {
  //   for (var url in downloadUrls) {
  //     MyRequestClass.krequest(
  //       endPoint: EndPoint.deleteImage,
  //       body: {"url": url},
  //       method: Methods.delete,
  //     );
  //   }
  // }

  Future<RequestResponsModel> verifyEmail(Map<String, String> data) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.validateEmailCode, body: data, method: Methods.post);
    return response;
  }

  Future<RequestResponsModel> requestEmailCode(Map<String, String> data) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.generateEmailToken,
        body: data,
        method: Methods.post);
    return response;
  }

  Future<RequestResponsModel> register(CreateAccountModel data) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.register, body: data.toJson(), method: Methods.put);
    return response;
  }

  Future<RequestResponsModel> login(Map<String, String> data) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.login, body: data, method: Methods.post);
    if (response.success) {
      AppSettings.saveUserToLocal(response.data);
    }
    return response;
  }

  Future<RequestResponsModel> goLive(Map<String, dynamic> data) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.goLiveAndOffline, body: data, method: Methods.patch);
    return response;
  }

  Future<RequestResponsModel> logOutUser() async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.logOut, method: Methods.post);
    return response;
  }

  Future<RequestResponsModel> refreshAuthToken() async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.refreshToken(userData.refreshToken),
        method: Methods.get);
    if (response.success) {
      AppSettings.updateLocalUserData(response.data);
    }
    return response;
  }
}
