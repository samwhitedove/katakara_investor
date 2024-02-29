import 'dart:developer';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/admin/model.fetch.red.flag.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/values/values.dart';
import '../../widgets/bottom.confirm.dart';

class RedFlagController extends GetxController {
  bool isLoading = false;
  bool isDeleting = false;
  final AdminService adminService = Get.find<AdminService>();

  int? id;

  final args = Get.arguments;

  List<RedFlags> redFlag = <RedFlags>[];
  Pagination? pagination;
  RedFlags? selectedData;

  RxBool fetchingMore = false.obs;

  @override
  void onInit() {
    fetchRedFlag();
    super.onInit();
  }

  fetchRedFlag({Map<String, dynamic>? data}) async {
    HC.hideKeyBoard();
    isLoading = true;
    update();
    final RequestResponseModel flag = data == null
        ? await adminService.fetchRedFlag()
        : await adminService.fetchRedFlag(query: data);
    redFlag.clear();
    log('${flag.data} --- red flag');
    if (flag.success) {
      for (var element in (flag.data['data'] as List)) {
        redFlag.add(RedFlags.fromJson(element));
      }
      pagination = Pagination.fromJson(flag.data['pagination']);
    }
    log(redFlag.toString());
    HC.snack(flag.message, success: flag.success);
    isLoading = false;
    update();
    return;
  }

  getMorePortfolio() async {
    fetchingMore.value = true;
    update();
    final RequestResponseModel flag =
        await adminService.fetchMoreRedFlag(pagination!.nextPage!);
    log('${flag.data} --- red flag');
    if (flag.success) {
      for (var element in (flag.data['data'] as List)) {
        redFlag.add(RedFlags.fromJson(element));
      }
      pagination = Pagination.fromJson(flag.data['pagination']);
    }
    HC.snack(flag.message, success: flag.success);
    fetchingMore.value = false;
    update();
    return;
  }

  viewinfo(ids) {
    id = ids;
    final selected = redFlag.where((element) => element.id == ids);
    if (selected.isNotEmpty) selectedData = selected.first;
    Get.toNamed(RouteName.viewRedFlagDetails.name);
  }

  handleDelete({int? id}) {
    return bottomConfirm(() => deleteFlag(index: id), title: "Delete Red Flag");
  }

  deleteFlag({int? index}) async {
    isLoading = true;
    update();
    final RequestResponseModel flag =
        await adminService.deleteRedFlag(index ?? id!);
    HC.snack(flag.message, success: flag.success);
    if (flag.success && index == null) Get.back();
    await fetchRedFlag(data: {"limit": redFlag.length});
    isLoading = false;
    update();
    return;
  }
}
