import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/admin/model.fetch.red.flag.dart';
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
  RedFlags? selectedData;

  @override
  void onInit() {
    fetchRedFlag();
    super.onInit();
  }

  fetchRedFlag() async {
    HC.hideKeyBoard();
    isLoading = true;
    update();
    final RequestResponseModel flag = await adminService.fetchRedFlag();
    redFlag.clear();
    if (flag.success) {
      for (var element in (flag.data['data'] as List)) {
        redFlag.add(RedFlags.fromJson(element));
      }
    }
    log(redFlag.toString());
    HC.snack(flag.message, success: flag.success);
    isLoading = false;
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
    await fetchRedFlag();
    isLoading = false;
    update();
    return;
  }
}
