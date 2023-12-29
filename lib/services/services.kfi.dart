import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class KFIService extends GetxController {
  Future<RequestResponseModel> inviteUser(
      {required Map<String, dynamic>? body}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.inviteKFI, method: Methods.post, body: body);
    return response;
  }

  Future<RequestResponseModel> acceptUser(
      {required Map<String, dynamic>? body}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.acceptInvite, method: Methods.post, body: body);
    return response;
  }

  Future<RequestResponseModel> unlinkUser(
      {required Map<String, dynamic>? body}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.unlineKFIInvite, method: Methods.post, body: body);
    return response;
  }

  Future<RequestResponseModel> acceptUnlinkUser(
      {required Map<String, dynamic>? body}) async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.acceptUnlink, method: Methods.post, body: body);
    return response;
  }

  Future<RequestResponseModel> fetchMergeUser() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchMerge, method: Methods.get);
    return response;
  }
}
