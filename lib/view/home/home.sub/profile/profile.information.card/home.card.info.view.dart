import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.sub/profile/profile.information.card/home.card.info.controller.dart';

class ViewInformationCard extends StatelessWidget {
  const ViewInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewCardInformationController>(
      init: ViewCardInformationController(),
      initState: (_) {},
      builder: (_) {
        log("${_.user} -------------- data");
        return Scaffold(
          body: Obx(
            () => Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: CW.backButton().align(Al.left),
                      ),
                      SizedBox(
                        height: Get.height * .3,
                        child: Column(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () => Get.toNamed(
                                    RouteName.fullImageView.name,
                                    arguments: {
                                      "image": _.user?.profileImageUrl ??
                                          Assets.assetsImagesImage,
                                      "tag": "profile"
                                    }),
                                child: Hero(
                                  tag: "profileImage",
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundImage:
                                        _.user?.profileImageUrl != null &&
                                                _.user?.profileImageUrl!
                                                    .startsWith('http')
                                            ? CachedNetworkImageProvider(
                                                    _.user?.profileImageUrl)
                                                as ImageProvider
                                            : const AssetImage(
                                                Assets.assetsImagesImage),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CW
                                    .button(
                                      isLoading: _.isTaskAdmin.value,
                                      color: _.isTaskBlock.value ||
                                              _.isTaskAdmin.value
                                          ? AppColor.greyLigth
                                          : _.action[
                                              _.user?.role == Roles.USER.name
                                                  ? 1
                                                  : 0]['color'] as Color,
                                      onPress: _.isTaskBlock.value ||
                                              _.isTaskAdmin.value
                                          ? null
                                          : () => _.adminAction[
                                              _.user?.role == Roles.USER.name
                                                  ? 1
                                                  : 0]['onTap'](),
                                      text: '',
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(_.adminAction[
                                                _.user?.role == Roles.USER.name
                                                    ? 1
                                                    : 0]['icon'] as IconData?),
                                          ),
                                          Text(
                                            _.adminAction[_.user!.role ==
                                                        Roles.USER.name
                                                    ? 1
                                                    : 0]['title']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    )
                                    .halfWidth(width: .45)
                                    .align(Al.center)
                                    .paddingOnly(top: 10, right: 10),
                                CW
                                    .button(
                                      isLoading: _.isTaskBlock.value,
                                      color: _.isTaskBlock.value ||
                                              _.isTaskAdmin.value
                                          ? AppColor.greyLigth
                                          : _.action[_.user!.isBlock! ? 1 : 0]
                                              ['color'] as Color,
                                      onPress: _.isTaskBlock.value ||
                                              _.isTaskAdmin.value
                                          ? null
                                          : () =>
                                              _.action[_.user!.isBlock! ? 1 : 0]
                                                  ['onTap'](),
                                      text: '',
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(_.action[
                                                    _.user!.isBlock! ? 1 : 0]
                                                ['icon'] as IconData?),
                                          ),
                                          Text(
                                            _.action[_.user!.isBlock! ? 1 : 0]
                                                    ['title']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    )
                                    .halfWidth(width: .4)
                                    .align(Al.center)
                                    .paddingOnly(top: 10, right: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: _.scrollController,
                          physics: const BouncingScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: _.userJson?.keys.length ?? 0,
                          itemBuilder: (context, index) =>
                              _.data[index] == "Profile Image" ||
                                      _.data[index] == "updateAt" ||
                                      _.data[index] == "id"
                                  ? const SizedBox()
                                  : ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        _.data[index],
                                      ).subTitle(fontSize: 12),
                                      subtitle: SelectableText(
                                        HC.formartValue(
                                            _.userJson!.values.toList()[index]),
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.subTitle,
                                        ),
                                      ),
                                      trailing: _.handleTrailing(index),
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
                CW.LoadingOverlay(_.isLoading.value),
              ],
            ),
          ),
        );
      },
    );
  }
}
