import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class ReceiptService extends GetxController {
  Future<RequestResponseModel> saveReceipt(Map<String, dynamic> data) async {
    RequestResponseModel response = await MyRequestClass.krequest(
      endPoint: EndPoint.createReciept,
      method: Methods.put,
      body: data,
    );
    return response;
  }

  Future<RequestResponseModel> fetchReceipt(
      {Map<String, dynamic>? query}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchReceipt,
        method: Methods.get,
        query: query ?? {});
    return response;
  }

  Future<RequestResponseModel> searchReceipt(Map<String, String> query) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchReceipt, method: Methods.get, query: query);
    return response;
  }

  Future<RequestResponseModel> fetchMoreReceipt(
      {Map<String, dynamic>? query, String? url}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: url ?? EndPoint.fetchReceipt,
        method: Methods.get,
        query: query);
    return response;
  }
}
