import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/admin/model.fetch.user.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/widgets/bottom.sheet.dart';

import '../../../../../models/services/model.service.response.dart';
import '../../../../../services/service.admin.dart';

class ViewCardInformationController extends GetxController {
  ScrollController scrollController = ScrollController();

  FetchedUser? user;
  Map<String, dynamic>? userJson;
  final AdminService adminService = Get.find<AdminService>();
  List<String> data = [
    "id",
    "Registered Date",
    'updateAt',
    "Email",
    "Full Name",
    "Phone Number",
    "Phone Number 2",
    "Account Name",
    "Account Number",
    "Profile Image",
    "CAC",
    "Government ID",
    "Letter Head",
    "Address",
    "State",
    "LGA",
    "Company Name",
    "Bank Name",
    "Government ID",
    "Own Vehicle",
    "Financial Capacity",
    "Unique ID",
    "Live",
    "Block",
    "Merge",
    "Role",
  ];
  RxBool isBlocked = false.obs;
  RxBool isLoading = false.obs;
  RxBool isTaskBlock = false.obs;

  RxBool isTaskAdmin = false.obs;

  get action => [
        {
          "icon": Icons.block,
          "title": "Block",
          "color": AppColor.red,
          "onTap": changeBlockStatus
        },
        {
          "icon": Icons.verified_user,
          "title": "Un-Block",
          "color": AppColor.primary,
          "onTap": changeBlockStatus
        }
      ];

  get adminAction => [
        {
          "icon": Icons.admin_panel_settings_sharp,
          "title": "Remove Admin",
          "color": AppColor.red,
          "onTap": removeAdmin
        },
        {
          "icon": Icons.person,
          "title": "Make Admin",
          "color": AppColor.primary,
          "onTap": changeRole
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

  changeBlockStatus() {
    return BottomSheetModal(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Are you sure to ${user!.isBlock! ? 'unblock' : 'block'} user ?")
                  .title(fontSize: 14, color: AppColor.black),
              GestureDetector(
                onTap: Get.back,
                child: const CircleAvatar(
                    backgroundColor: AppColor.red,
                    radius: 10,
                    child: Icon(
                      Icons.close,
                      size: 12,
                      color: AppColor.white,
                    )),
              )
            ],
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CW
                .button(
                    onPress: user!.isBlock! ? _unBlockUser : _blockUser,
                    text: "Yes",
                    color: AppColor.red)
                .halfWidth(width: .4),
            CW
                .button(
                  onPress: Get.back,
                  text: "No",
                )
                .halfWidth(width: .4),
          ],
        ),
      ],
    ));
  }

  _blockUser() async {
    Get.back();
    isTaskBlock.value = true;
    RequestResponseModel? response = await adminService.blockUser(user!.id!);
    if (response.success) await _fetchUserInformation();
    isTaskBlock.value = false;
    HC.snack(response.message, success: response.success);
  }

  _unBlockUser() async {
    Get.back();
    isTaskBlock.value = true;
    RequestResponseModel? response = await adminService.unBlockUser(user!.id!);
    if (response.success) await _fetchUserInformation();
    isTaskBlock.value = false;
    HC.snack(response.message, success: response.success);
  }

  removeAdmin() async {
    return BottomSheetModal(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Are you sure to remove admin ?")
                  .title(fontSize: 14, color: AppColor.black),
              GestureDetector(
                onTap: Get.back,
                child: const CircleAvatar(
                    backgroundColor: AppColor.red,
                    radius: 10,
                    child: Icon(
                      Icons.close,
                      size: 12,
                      color: AppColor.white,
                    )),
              )
            ],
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CW
                .button(
                    onPress: () => _changeRole(Roles.USER),
                    text: "Yes",
                    color: AppColor.red)
                .halfWidth(width: .4),
            CW
                .button(
                  onPress: Get.back,
                  text: "No",
                )
                .halfWidth(width: .4),
          ],
        ),
      ],
    ));
  }

  changeRole() async {
    return BottomSheetModal(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Select admin role type")
                  .title(fontSize: 14, color: AppColor.black),
              GestureDetector(
                onTap: Get.back,
                child: const CircleAvatar(
                    backgroundColor: AppColor.red,
                    radius: 10,
                    child: Icon(
                      Icons.close,
                      size: 12,
                      color: AppColor.white,
                    )),
              )
            ],
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CW
                .button(
                    onPress: () => _changeRole(Roles.ADMIN), text: "Make Admin")
                .halfWidth(width: .45),
            CW
                .button(
                    color: AppColor.black,
                    onPress: () => _changeRole(Roles.SUPER_ADMIN),
                    text: "Make Super Admin")
                .halfWidth(width: .45),
          ],
        ),
      ],
    ));
  }

  _changeRole(Roles role) async {
    Get.back();
    isTaskAdmin.value = true;
    RequestResponseModel? response = await adminService
        .makeAdmin({"email": user!.email!, "status": role.name});
    if (response.success) await _fetchUserInformation();
    isTaskAdmin.value = false;
    HC.snack(response.message, success: response.success);
  }

  handleClick(int index) {
    //TODO SHOW MERGE ACCOUNT
    // String title = data[index];
    // switch (title) {
    //   case "Government ID":
    //   case "Letter Head":
    //   case "CAC":
    //     break;
    //   case "Merge":
    //     break;
    //   default:
    // }
  }

  Widget handleTrailing(int index) {
    String title = data[index];
    log(title);
    switch (title) {
      case "Government ID":
      case "Letter Head":
      case "CAC":
        if (userJson!.values.toList()[index] == null) return const SizedBox();
        if (userJson!.values.toList()[index].isEmptyl) return const SizedBox();
        if (!userJson!.values.toList()[index].startsWith('http')) {
          return const SizedBox();
        }
        return GestureDetector(
            onTap: () => Get.toNamed(RouteName.fullImageView.name, arguments: {
                  "tag": "image",
                  "image": userJson!.values.toList()[index]
                }),
            child:
                CachedNetworkImage(imageUrl: userJson!.values.toList()[index]));
      // case "Merge":
      //   return const Text("View Merge").title(fontSize: 12);
      default:
        return const SizedBox();
    }
  }
}
