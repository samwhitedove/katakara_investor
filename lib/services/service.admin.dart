import 'dart:developer';

import 'package:get/get.dart';
import 'package:katakara_investor/models/product/model.investment.dart';
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

  Future<RequestResponseModel> updateFaq(Map<String, dynamic> body) async {
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

  Future<RequestResponseModel> deleteRedFlag(int id) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteRedFlag(id), method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchRedFlag() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchRedFlag, method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchUsersReceipt() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUsersReceipt, method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchMoreUsersReceipt({String? url}) async {
    RequestResponseModel response =
        await MyRequestClass.krequest(endPoint: url!, method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchSortUsersReceipt(
      {Map<String, String>? data}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUsersReceipt, method: Methods.get, query: data);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> deleteReceipts(int id) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteReceipt(id), method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> approveReceipts(int id) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.approveReceipt(id), method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> rejectReceipts(int id) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.rejectReceipt(id), method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> makeAdmin(Map<String, String> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.makeAdmin, method: Methods.post, body: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> saveYoutubeLink(Map<String, String> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.addYoutube, method: Methods.post, body: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> addCategory(Map<String, String> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.addCategory, method: Methods.post, body: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> deleteCategory(Map<String, int> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteCategory, method: Methods.get, query: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> updateCategory(Map<String, dynamic> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.updateCategory, method: Methods.post, body: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> addInvestment(InvestmentDataModel data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.addInvestment,
        method: Methods.post,
        body: data.toJson());
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> updateInvestment(
      Map<String, dynamic> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.updateInvestment, method: Methods.post, body: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> deleteInvestment(Map<String, int> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteInvestment, method: Methods.get, query: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchInvestment() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchInvestment, method: Methods.get);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> filterInvestment(
      Map<String, dynamic>? data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchInvestment, method: Methods.get, query: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> searchInvestment(
      Map<String, dynamic>? data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchInvestment, method: Methods.get, query: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchMoreInvestment({String? url}) async {
    RequestResponseModel response =
        await MyRequestClass.krequest(endPoint: url!, method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }
}
