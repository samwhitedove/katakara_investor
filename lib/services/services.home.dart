import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class HomeService extends GetxController {
  Future<RequestResponsModel> fetchYoutube() async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchYoutubeVideo, method: Methods.get);
    return response;
  }

  Future<RequestResponsModel> fetchFaq() async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchFaq, method: Methods.get);
    return response;
  }

  // RequestResponsModel model = await MyRequestClass.krequest(
  //       endPoint: EndPoint.fetchFaq, method: Methods.get);
}
