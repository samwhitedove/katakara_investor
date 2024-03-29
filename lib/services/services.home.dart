import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class HomeService extends GetxController {
  Future<RequestResponseModel> fetchYoutube() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchYoutubeVideo, method: Methods.get);
    return response;
  }

  Future<RequestResponseModel> fetchFaq() async {
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchFaq, method: Methods.get);
    return response;
  }

  Future<RequestResponseModel> fetchUserInvestment(
      Map<String, dynamic> map) async {
    //TODO change to user url
    RequestResponseModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchInvestment, method: Methods.get, query: map);
    return response;
  }

  // RequestResponsModel model = await MyRequestClass.krequest(
  //       endPoint: EndPoint.fetchFaq, method: Methods.get);
}
