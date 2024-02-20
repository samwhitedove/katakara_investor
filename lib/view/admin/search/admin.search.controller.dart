import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';

import '../../../models/admin/model.fetch.user.dart';
import '../../../models/services/model.service.response.dart';
import '../../../services/service.admin.dart';
import '../users/admin.user.controller.dart';

class AppSearchController extends GetxController {
  String get title => makeTitle();
  TextEditingController searchController = TextEditingController();
  final AdminService adminService = Get.find<AdminService>();
  Map<String, dynamic> searchedUser = <String, dynamic>{
    "pagination": <Pagination>{},
    "users": <FetchedUser>[]
  };
  final UserViewType args = Get.arguments;

  String makeTitle() {
    switch (args) {
      case UserViewType.all:
        return "User";
      case UserViewType.block:
        return "Block";
      default:
        return "";
    }
  }

  RxBool isFetching = false.obs;
  RxBool hasSearch = false.obs;

  searchUser() async {
    isFetching(true);
    HC.hideKeyBoard();
    await fetchSearchedUser(args == UserViewType.block);
    hasSearch(true);
    isFetching(false);
  }

  fetchSearchedUser(bool isBlock) async {
    RequestResponseModel? responseModel =
        await adminService.searchUser(searchController.text, block: isBlock);
    if (responseModel.success) {
      final decode = FetchAllUser.fromJson(responseModel.data);
      searchedUser['users'] = decode.data;
      searchedUser['pagination'] = decode.pagination;
      return;
    }
    HC.snack(responseModel.message, success: responseModel.success);
  }
}
