import 'dart:developer';

import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.home.dart';
import 'package:katakara_investor/values/values.dart';

class FaqController extends GetxController {
  bool isLoading = false;
  List<Map<String, dynamic>> data = [];
  final HomeService homeService = Get.find<HomeService>();

  final fromAdmin = Get.arguments;

  updateIsView(int index, Map<String, dynamic> incoming) {
    if (fromAdmin != null) {
      return Get.toNamed(RouteName.addFaq.name, arguments: incoming);
    }
    data[index]['isView'] = !incoming['isView'];
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
    log('$data ----------- data --------');
    final RequestResponseModel faq = await homeService.fetchFaq();
    if (faq.success) {
      data.clear();
      for (Map<String, dynamic> element in faq.data) {
        data.add(element..addAll({"isView": false}));
      }
    }
    isLoading = false;
    update();
    return;
  }
}
