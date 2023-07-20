import 'dart:developer';

import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class FaqController extends GetxController {
  bool isLoading = false;
  List<Map<String, dynamic>> data = [];

  updateIsView(int index, bool value) {
    data[index]['isView'] = !value;
    update();
  }

  @override
  void onInit() {
    loadFaq();
    super.onInit();
  }

  loadFaq() async {
    isLoading = true;
    update();
    RequestResponsModel model = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchFaq, method: Methods.get);
    if (model.success) {
      for (Map<String, dynamic> element in model.data['item']) {
        data.add(element..addAll({"isView": false}));
      }
      log(data.toString());
      log(model.toJson().toString());
      isLoading = false;
      update();
      return;
    }
    isLoading = false;
  }
}
