import 'package:get/get.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/services.home.dart';

class FaqController extends GetxController {
  bool isLoading = false;
  List<Map<String, dynamic>> data = [];
  final HomeService homeService = Get.find<HomeService>();

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
    final RequestResponsModel faq = await homeService.fetchFaq();
    if (faq.success && data.isNotEmpty) {
      for (Map<String, dynamic> element in faq.data['item']) {
        data.add(element..addAll({"isView": false}));
      }
    }
    isLoading = false;
    update();
    return;
  }
}
