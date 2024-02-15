import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/services/service.admin.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/users/admin.user.controller.dart';

class AdminDashboardController extends GetxController {
  // ignore: unused_field
  final _ = Get.put(AdminService());
  List<Map<String, dynamic>> data = [
    {
      'title': "Registered Users",
      'icon': Icons.group,
      "value": 122,
      'color': AppColor.blue,
      "onTap": () =>
          Get.toNamed(RouteName.user.name, arguments: UserViewType.all)
    },
    {
      'title': "Category",
      'icon': Icons.category,
      "value": 200,
      'color': AppColor.primary,
      "onTap": () => Get.toNamed(RouteName.productCategory.name,
          arguments: UserViewType.join)
    },
    {
      'title': "Investment Available",
      'icon': Icons.propane,
      "value": 150,
      'color': AppColor.purple,
      "onTap": () => Get.toNamed(RouteName.activeProduct.name)
    },
    // {
    //   'title': "Booked Products",
    //   'icon': Icons.menu_book_rounded,
    //   "value": 500,
    //   'color': AppColor.orange,
    //   "onTap": () => Get.toNamed(RouteName.bookedProduct.name)
    // },
    // {
    //   'title': "Blocked Users",
    //   'icon': Icons.person_off_sharp,
    //   "value": 200,
    //   'color': AppColor.lightRed,
    //   "onTap": () =>
    //       Get.toNamed(RouteName.user.name, arguments: UserViewType.block)
    // },
    {
      'title': "BroadCast",
      'icon': Icons.screenshot_sharp,
      "value": 500,
      'color': AppColor.brown,
      "onTap": () => Get.toNamed(RouteName.broadcast.name)
    },
    {
      'title': "Add Product",
      'icon': Icons.add_shopping_cart_rounded,
      "value": 500,
      'color': AppColor.red,
      "onTap": () => Get.toNamed(RouteName.addInvestment.name)
    },
    {
      'title': "Red Flag",
      'icon': Icons.crisis_alert_sharp,
      "value": 500,
      'color': AppColor.primary,
      "onTap": () => Get.toNamed(RouteName.viewRedFlag.name)
    },
    {
      'title': "Receipts",
      'icon': Icons.receipt,
      "value": 500,
      'color': AppColor.orange,
      "onTap": () => Get.toNamed(RouteName.adminViewReceipts.name)
    },
    {
      'title': "Add Youtube",
      'icon': Icons.play_arrow,
      "value": 500,
      'color': AppColor.blue,
      "onTap": () => Get.toNamed(RouteName.youtubeUrl.name)
    },
    {
      'title': "Add Faq",
      'icon': Icons.question_mark_sharp,
      "value": 500,
      'color': AppColor.purple,
      "onTap": () => Get.toNamed(RouteName.faq.name, arguments: "admin")
    }
  ];
}
