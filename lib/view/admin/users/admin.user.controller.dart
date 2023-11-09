import 'package:get/get.dart';

enum UserViewType { all, block, join }

class UserListController extends GetxController {
  final UserViewType pageType = Get.arguments;
  String setTitle() {
    switch (pageType) {
      case UserViewType.all:
        return "All Users";
      case UserViewType.join:
        return "New Users";
      case UserViewType.block:
        return "Block Users";
      default:
        return "Un-Categorized User";
    }
  }
}
