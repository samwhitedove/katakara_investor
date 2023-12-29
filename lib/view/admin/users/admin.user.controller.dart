import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/admin/model.fetch.user.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';

enum UserViewType { all, block, join }

class UserListController extends GetxController {
  final UserViewType pageType = Get.arguments;
  final AdminService adminService = Get.find<AdminService>();
  String? title;

  @override
  void onInit() {
    setTitle();
    super.onInit();
  }

  void setTitle() {
    switch (pageType) {
      case UserViewType.all:
        title = "All Users";
        break;
      case UserViewType.join:
        title = "New Users";
        break;
      case UserViewType.block:
        title = "Block Users";
        break;
      default:
        title = "Un-Categorized User";
        break;
    }
    fetchAllAppUser(pageType);
  }

  RxBool isFetchingAllUser = false.obs;
  RxBool isFetchingMoreUser = false.obs;
  Map<String, dynamic> fetchedUser = <String, dynamic>{
    "pagination": <Pagination>{},
    "users": <FetchedUser>[]
  };

  fetchMoreData(UserViewType type) async {
    String? page = fetchedUser['pagination']['nextPage'];
    if (page == null) return;
    isFetchingMoreUser(true);
    update();
    final RequestResponseModel responseModel =
        await adminService.fetchMoreUser(page);
    isFetchingMoreUser(false);
    update();
    if (responseModel.success) {
      final decode = FetchAllUser.fromJson(responseModel.data);
      fetchedUser['users'].addAll(decode.data);
      fetchedUser['pagination'] = decode.pagination;
      return;
    }
    HC.snack(responseModel.message, success: responseModel.success);
  }

  fetchAllAppUser(UserViewType type) async {
    isFetchingAllUser(true);
    update();
    RequestResponseModel? responseModel;
    switch (type) {
      case UserViewType.all:
        responseModel = await adminService.fetchAllUser();
        break;
      case UserViewType.block:
        responseModel = await adminService.fetchAllBlockedUser();
        break;
      case UserViewType.join:
        responseModel = await adminService.fetchAllTodayUser();
        break;
      default:
    }
    isFetchingAllUser(false);
    update();
    if (responseModel!.success) {
      final decode = FetchAllUser.fromJson(responseModel.data);
      fetchedUser['users'] = decode.data;
      // log("${decode.data} done processing call ------- ------- ---");
      fetchedUser['pagination'] = decode.pagination;
      // log("${fetchedUser['pagination'].toJson()} done processing call --qqq----- ------- ---");
      return;
    }
    HC.snack(responseModel.message, success: responseModel.success);
  }
}
