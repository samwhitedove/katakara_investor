import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class KFIService extends GetxController {
  Future<RequestResponsModel> inviteUser(
      {required Map<String, dynamic>? body}) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.inviteKFI, method: Methods.post, body: body);
    return response;
  }

  Future<RequestResponsModel> acceptUser(
      {required Map<String, dynamic>? body}) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.acceptInvite, method: Methods.post, body: body);
    return response;
  }

  Future<RequestResponsModel> unlinkUser(
      {required Map<String, dynamic>? body}) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.unlineKFIInvite, method: Methods.post, body: body);
    return response;
  }

  Future<RequestResponsModel> acceptUnlinkUser(
      {required Map<String, dynamic>? body}) async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.acceptUnlink, method: Methods.post, body: body);
    return response;
  }

  Future<RequestResponsModel> fetchMergeUser() async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchMerge, method: Methods.get);
    return response;
  }
}
