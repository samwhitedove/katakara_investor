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
        return Obx(
          () => Stack(
            children: [
              CW.pageWithAppBar(
                scroll: const NeverScrollableScrollPhysics(),
                title: "User Information",
                children: [
                  CW.AppSpacer(h: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: _.user?.profileImageUrl != null &&
                              _.user?.profileImageUrl!.startsWith('http')
                          ? CachedNetworkImageProvider(_.user?.profileImageUrl)
                              as ImageProvider
                          : const AssetImage(Assets.assetsImagesImage),
                    ),
                  ),
                  CW
                      .button(
                        isLoading: _.isOperating.value,
                        color: _.isOperating.value
                            ? AppColor.greyLigth
                            : _.action[_.user!.isBlock! ? 1 : 0]['color']
                                as Color,
                        onPress: () =>
                            _.action[_.user!.isBlock! ? 1 : 0]['onTap'](),
                        text: '',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(_.action[_.user!.isBlock! ? 1 : 0]
                                  ['icon'] as IconData?),
                            ),
                            Text(
                              _.action[_.user!.isBlock! ? 1 : 0]['title']
                                  .toString(),
                            ),
                          ],
                        ),
                      )
                      .halfWidth()
                      .align(Al.center)
                      .paddingOnly(top: 10),
                  SizedBox(
                    height: Get.height * .75,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _.userJson?.keys.length ?? 0,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          _.data[index],
                        ).subTitle(fontSize: 12),
                        subtitle: Text(
                          HC.formartValue(_.userJson!.values.toList()[index]),
                        ).subTitle(
                          fontSize: 13,
                          bold: true,
                        ),
                        trailing: _.handleTrailing(index),
                        onTap: () => _.handleClick(index),
                      ),
                    ),
                  ),
                ],
              ),
              CW.LoadingOverlay(_.isLoading.value),
            ],
          ),
        );
      },
    );
  }
}
