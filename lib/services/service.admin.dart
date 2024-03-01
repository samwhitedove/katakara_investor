import 'dart:developer';
import 'dart:io';

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

  Future<RequestResponseModel> fetchAllAdminUser() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUser(type: 'admins'), method: Methods.get);
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

  Future<RequestResponseModel> fetchRedFlag(
      {Map<String, dynamic>? query}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchRedFlag, method: Methods.get, query: query);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchMoreRedFlag(String url) async {
    RequestResponseModel response =
        await MyRequestClass.krequest(endPoint: url, method: Methods.get);
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

  Future<RequestResponseModel> addCategory(
      Map<String, String> data, File? filePath) async {
    RequestResponseModel response =
        await MyRequestClass.krequestWithImagePayload(
            endPoint: EndPoint.addCategory,
            method: Methods.post,
            body: data,
            filePath: filePath);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> deleteCategory(Map<String, int> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteCategory, method: Methods.get, query: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> updateCategory(
      Map<String, String> data, File? filePath) async {
    RequestResponseModel response =
        await MyRequestClass.krequestWithImagePayload(
            endPoint: EndPoint.updateCategory,
            method: Methods.post,
            body: data,
            filePath: filePath);
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

  Future<RequestResponseModel> deleteInvestment(
      Map<String, String> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteInvestment, method: Methods.get, query: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> deleteProduct(Map<String, String> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.deleteInvestment, method: Methods.get, query: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchUsersPortfolio(
      {Map<String, dynamic>? data}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUserPortfolio,
        method: Methods.get,
        query: data);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> fetchMoreUserPortfolio({String? url}) async {
    RequestResponseModel response =
        await MyRequestClass.krequest(endPoint: url!, method: Methods.get);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> setCommission(Map<String, dynamic> query) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.setCommission, method: Methods.get, query: query);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> approveUsersPortfolio(
      Map<String, dynamic> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.approveProduct, method: Methods.get, query: data);
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> rejectUsersPortfolio(
      String data, String reason) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.rejectProduct,
        method: Methods.get,
        query: {"sku": data, "reason": reason});
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> publishUsersPortfolio(String data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.publishProduct,
        method: Methods.get,
        query: {"sku": data});
    log("unblock user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> searchPortfolio(
      Map<String, dynamic>? data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUserPortfolio,
        method: Methods.get,
        query: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }

  Future<RequestResponseModel> sendBroadcast(Map<String, dynamic>? data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.sendBroadcast, method: Methods.post, body: data);
    log("make admin user info ------- ${response.message}");
    return response;
  }
}
