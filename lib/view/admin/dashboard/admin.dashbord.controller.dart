import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/admin/users/admin.user.controller.dart';

class AdminDashboardController extends GetxController {
  List<Map<String, dynamic>> data = [
    {
      'title': "Total Users",
      'icon': Icons.group,
      "value": 122,
      'color': AppColor.blue,
      "onTap": () =>
          Get.toNamed(RouteName.user.name, arguments: UserViewType.all)
    },
    {
      'title': "Sign-ups Today",
      'icon': Icons.group_add,
      "value": 200,
      'color': AppColor.primary,
      "onTap": () =>
          Get.toNamed(RouteName.user.name, arguments: UserViewType.join)
    },
    {
      'title': "Active Products",
      'icon': Icons.propane,
      "value": 150,
      'color': AppColor.purple,
      "onTap": () => Get.toNamed(RouteName.activeProduct.name)
    },
    {
      'title': "Booked Products",
      'icon': Icons.menu_book_rounded,
      "value": 500,
      'color': AppColor.orange,
      "onTap": () => Get.toNamed(RouteName.bookedProduct.name)
    },
    {
      'title': "Blocked Users",
      'icon': Icons.person_off_sharp,
      "value": 200,
      'color': AppColor.lightRed,
      "onTap": () =>
          Get.toNamed(RouteName.user.name, arguments: UserViewType.block)
    },
    {
      'title': "BroadCast",
      'icon': Icons.screenshot_sharp,
      "value": 500,
      'color': AppColor.brown,
      "onTap": () => () => Get.toNamed(RouteName.broadcast.name)
    },
    {
      'title': "Add Product",
      'icon': Icons.add_shopping_cart_rounded,
      "value": 500,
      'color': AppColor.red,
      "onTap": () => Get.toNamed(RouteName.addProduct.name)
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
      "onTap": () => Get.toNamed(RouteName.usersReceipts.name)
    },
    {
      'title': "Add Receipt",
      'icon': Icons.receipt_long_rounded,
      "value": 500,
      'color': AppColor.blue,
      "onTap": () => Get.toNamed(RouteName.addReceipts.name)
    },
    {
      'title': "Add Faq",
      'icon': Icons.question_mark_sharp,
      "value": 500,
      'color': AppColor.purple,
      "onTap": () => Get.toNamed(RouteName.addFaq.name)
    }
  ];
}
