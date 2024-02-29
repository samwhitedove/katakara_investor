import 'package:get/get.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/admin/model.fetch.user.dart';
import 'package:katakara_investor/models/receipt/model.fetch.reponse.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.admin.dart';

enum UserViewType { all, today, blocked, admins }

class UserListController extends GetxController {
  late UserViewType pageType = Get.arguments;
  final AdminService adminService = Get.find<AdminService>();
  String? title;
  int selected = 0;

  final List<String> userListType = <String>[
    'All Users',
    'New Users',
    'Block Users',
    'All Admin',
  ];

  @override
  void onInit() {
    changeUserType('all');
    super.onInit();
  }

  changeUserType([String? text]) {
    if (userListType[selected] == text) return;
    text = text!.capitalize!;
    switch (text) {
      case "All Users":
        selected = 0;
        pageType = UserViewType.all;
        title = "All Users";
        // update();
        break;
      case "New Users":
        selected = 1;
        pageType = UserViewType.today;
        title = "New Users";
        // update();
        break;
      case "Block Users":
        selected = 2;
        pageType = UserViewType.blocked;
        title = "Block Users";
        // update();
        break;
      case 'All Admin':
        selected = 3;
        pageType = UserViewType.admins;
        title = "Admin Users";
        // update();
        break;
      default:
        selected = 0;
        title = "All User";
        pageType = UserViewType.all;
        update();
        break;
    }
    fetchAllAppUser(pageType);
  }

  RxBool isFetchingAllUser = false.obs;
  RxBool isFetchingMoreUser = false.obs;
  List<FetchedUser>? fetchedUser = <FetchedUser>[];
  Pagination? pagination;
  // Map<String, dynamic> fetchedUser = <String, dynamic>{
  //   "pagination": <Pagination>{},
  //   "users": <FetchedUser>[]
  // };

  fetchMoreData(UserViewType type) async {
    String? page = pagination?.nextPage;
    if (page == null) return;
    isFetchingMoreUser(true);
    update();
    final RequestResponseModel responseModel =
        await adminService.fetchMoreUser(page);
    isFetchingMoreUser(false);
    update();
    if (responseModel.success) {
      final decode = FetchAllUser.fromJson(responseModel.data);
      for (var element in decode.data!) {
        fetchedUser!.add(element);
      }
      pagination = decode.pagination!;
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
      case UserViewType.blocked:
        responseModel = await adminService.fetchAllBlockedUser();
        break;
      case UserViewType.today:
        responseModel = await adminService.fetchAllTodayUser();
        break;
      case UserViewType.admins:
        responseModel = await adminService.fetchAllAdminUser();
        break;
      default:
        responseModel = await adminService.fetchAllUser();
    }
    isFetchingAllUser(false);
    update();
    if (responseModel.success) {
      final decode = FetchAllUser.fromJson(responseModel.data);
      fetchedUser = decode.data;
      pagination = decode.pagination!;
      return;
    }
    HC.snack(responseModel.message, success: responseModel.success);
  }
}
