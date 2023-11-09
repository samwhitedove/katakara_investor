import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class ReceiptService extends GetxController {
  Future<RequestResponsModel> saveReceipt(Map<String, dynamic> data) async {
    RequestResponsModel response = await MyRequestClass.krequest(
      endPoint: EndPoint.createReciept,
      method: Methods.put,
      body: data,
    );
    return response;
  }

  Future<RequestResponsModel> fetchReceipt() async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchReceipt, method: Methods.get);
    return response;
  }
}
