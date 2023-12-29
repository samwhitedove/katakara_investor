import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/admin/model.fetch.user.dart';
import 'package:katakara_investor/values/values.dart';

import '../../../../../models/services/model.service.response.dart';
import '../../../../../services/service.admin.dart';

class ViewCardInformationController extends GetxController {
  FetchedUser? user;
  Map<String, dynamic>? userJson;
  final AdminService adminService = Get.find<AdminService>();
  List<String> data = [
    "id",
    "Created At",
    'Update At',
    "Email",
    "Full Name",
    "Phone Number",
    "Phone Number 2",
    "Account Name",
    "Account Number",
    "Profile Image",
    "CAC",
    "Government Id",
    "LetterHead Image",
    "Address",
    "State",
    "LGA",
    "Company Name",
    "Bank Name",
    "Government Id",
    "Own Vehicle",
    "Financial Capacity",
    "Unique Id",
    "Merge Count",
    "Live",
    "Blocked",
    "Merged",
  ];
  RxBool isBlocked = false.obs;
  RxBool isLoading = false.obs;
  RxBool isOperating = false.obs;

  get action => [
        {
          "icon": Icons.block,
          "title": "Block",
          "color": AppColor.red,
          "onTap": () => blockUser()
        },
        {
          "icon": Icons.verified_user,
          "title": "Un-Block",
          "color": AppColor.primary,
          "onTap": () => unBlockUser()
        }
      ];

  @override
  void onInit() {
    user = Get.arguments;
    _fetchUserInformation();
    super.onInit();
  }

  _fetchUserInformation() async {
    isLoading.value = true;
    RequestResponseModel? response = await adminService.searchUser(user!.uuid!);
    if (response.success) {
      user = FetchedUser.fromJson(response.data['data'][0]);
      userJson = user!.toJson();
      isBlocked.value = user!.isBlock!;
    }
    isLoading.value = false;
    HC.snack(response.message, success: response.success);
  }

  blockUser() async {
    isOperating.value = true;
    RequestResponseModel? response = await adminService.blockUser(user!.id!);
    if (response.success) await _fetchUserInformation();
    isOperating.value = false;
    HC.snack(response.message, success: response.success);
  }

  unBlockUser() async {
    isOperating.value = true;
    RequestResponseModel? response = await adminService.unBlockUser(user!.id!);
    if (response.success) await _fetchUserInformation();
    isOperating.value = false;
    HC.snack(response.message, success: response.success);
  }

  handleClick(int index) {
    String title = data[index];
    switch (title) {
      case "Government Id":
      case "LetterHead Image":
      case "CAC":
        break;
      case "Merged":
        break;
      default:
    }
  }

  Widget handleTrailing(int index) {
    String title = data[index];
    log(title);
    switch (title) {
      case "Government Id":
      case "LetterHead Image":
      case "CAC":
        log("Ltter imageges ------- -- - - - ");
        if (userJson!.values.toList()[index] == null) return const SizedBox();
        if (userJson!.values.toList()[index].isEmptyl) return const SizedBox();
        if (!userJson!.values.toList()[index].startsWith('http')) {
          return const SizedBox();
        }
        return CachedNetworkImage(imageUrl: userJson!.values.toList()[index]);
      case "Merged":
        log("Ltter imageges ------- -- - - - ");
        return const Text("View Merge").title(fontSize: 12);
      default:
        return const SizedBox();
    }
  }
}
