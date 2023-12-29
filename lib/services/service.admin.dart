import 'dart:developer';

import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class AdminService extends GetxController {
  Future<RequestResponseModel> fetchAllUser() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUser(), method: Methods.get);
    log("Updating user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchAllBlockedUser() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUser(type: 'blocked'), method: Methods.get);
    log("Updating user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchAllTodayUser() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUser(type: 'today'), method: Methods.get);
    log("Updating user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> searchUser(String find,
      {bool block = false}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUser(type: 'search', find: find, block: block),
        method: Methods.get);
    log("Updating user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchMoreUser(String url) async {
    RequestResponseModel response =
        await MyRequestClass.krequest(endPoint: url, method: Methods.get);
    log("Updating user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> blockUser(int id) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.blockUser(id), method: Methods.get);
    log("block user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> unBlockUser(int id) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.unblockUser(id), method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> saveFaq(Map<String, dynamic> body) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.addFaq, method: Methods.post, body: body);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> updateFaq(Map<String, String> body) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.updateFaq, method: Methods.patch, body: body);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> deleteFaq(int id) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteFaq(id), method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }
}
