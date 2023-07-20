import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/values.dart';
import 'package:katakara_investor/view/home/home.dart';

class ProfilePageScreen extends StatelessWidget {
  final HomeScreenController ctr;
  const ProfilePageScreen({super.key, required this.ctr});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profile) => SafeArea(
        child: CW.baseWidget(
          isLoading: profile.isLoading.value,
          children: [
            Column(
              children: [
                CW.AppSpacer(h: 50),
                Center(
                  child: CW.AppSpacer(h: 10),
                ),
                Builder(builder: (context) {
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: userData.profileImageUrl!.isNotEmpty
                            ? CachedNetworkImageProvider(
                                userData.profileImageUrl!) as ImageProvider
                            : AssetImage(Assets.assetsImagesImage),
                      ),
                      Obx(
                        () => Positioned.fill(
                          child: Visibility(
                            visible: profile.isUploadingImage.value,
                            child: SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Obx(
                          () => Visibility(
                            visible: !profile.isUploadingImage.value,
                            child: CircleAvatar(
                                radius: 13,
                                child: Icon(
                                  Icons.edit,
                                  size: 10,
                                )).toButton(
                              onTap: () => profile.changeProfileImage(profile),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                CW.AppSpacer(h: 10),
                Text(userData.fullName!).title(fontSize: 16),
                CW.AppSpacer(h: 1),
                Text(userData.email!).subTitle(fontSize: 12),
              ],
            ),
            CW.AppSpacer(h: 30),
            ...List.generate(
              profile.menuData().length,
              (index) => profileMenuList(
                profile.menuData()[index]['label'],
                profile.menuData()[index]['icon'],
                profile.menuData()[index]['onTap'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileMenuList(String label, String icon, Function() onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: AppColor.primaryLight,
              child: SvgPicture.asset(
                icon, height: 17,
                // ignore: deprecated_member_use
                color: AppColor.primary,
              ),
            ),
            CW.AppSpacer(w: 10),
            Text(label).title(color: AppColor.text, fontSize: 14)
          ],
        ),
        const Icon(
          Icons.arrow_forward_ios,
          color: AppColor.text,
          size: 14,
        )
      ],
    )
        .roundCorner(
          showBorder: false,
          blurRadius: 1,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          borderColor: Colors.white10,
          bgColor: AppColor.white,
        )
        .marginSymmetric(vertical: 10)
        .toButton(onTap: () => onTap());
  }
}
