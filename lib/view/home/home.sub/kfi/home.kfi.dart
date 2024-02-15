// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.product.load.dart';
import 'package:katakara_investor/customs/custom.product.type.dart';
import 'package:katakara_investor/customs/customs.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/models/kfi/model.kfi.dart';
import 'package:katakara_investor/values/values.dart';

import 'package:katakara_investor/view/view.dart';

class KFIPageScreen extends StatefulWidget {
  final HomeScreenController ctr;
  KFIPageScreen({super.key, required this.ctr});

  @override
  State<KFIPageScreen> createState() => _KFIPageScreenState();
}

class _KFIPageScreenState extends State<KFIPageScreen>
    with TickerProviderStateMixin {
  TabController? controller;
  // final homeControl = Get.put(HomeKFIController());
  // final homeController = Get.find<HomeKFIController>();

  @override
  void initState() {
    super.initState();
    // homeController.homeScreenController = widget.ctr;
    // homeController.homeScreenController = widget.ctr;
    controller = TabController(length: 2, vsync: this);
    controller?.addListener(() {
      Get.find<HomeKFIController>().changeTab(controller!.index);
    });
  }

  @override
  void dispose() {
    controller?.removeListener(() {});
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<HomeKFIController>(
      init: HomeKFIController(),
      builder: (_) {
        return Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Scaffold(
                  floatingActionButton: _.currentKfi.value == 1
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () =>
                                  InviteUser(context, _, isAccept: true),
                              label: const Text("Accept Invite"),
                            ),
                            CW.AppSpacer(h: 20),
                            FloatingActionButton.extended(
                              onPressed: () => InviteUser(context, _),
                              label: const Row(
                                children: [Icon(Icons.add), Text("Invite KFI")],
                              ),
                            ),
                          ],
                        )
                      : null,
                  body: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CW.AppSpacer(h: 50),
                              const Text(tFractionalInvestors)
                                  .title(color: AppColor.white, fontSize: 22)
                                  .center,
                              const Text(tKfiContent)
                                  .subTitle(
                                      color: AppColor.white,
                                      fontSize: 12,
                                      lines: 6,
                                      align: TextAlign.center)
                                  .paddingSymmetric(vertical: 20),
                              TabBar(
                                indicatorSize: TabBarIndicatorSize.label,
                                dividerHeight: 0,
                                indicator: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: AppColor.white,
                                ),
                                controller: controller,
                                tabs: List.generate(
                                  _.fkis.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_.fkis[index]).title(
                                      color: _.currentKfi.value == index
                                          ? AppColor.primary
                                          : AppColor.white,
                                      fontSize:
                                          _.currentKfi.value == index ? 13 : 11,
                                    ),
                                    // ).toButton(
                                    // onTap: () => _.changeTab(index),
                                  ),
                                ),
                              ),
                              CW.AppSpacer(h: 20),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        // height: 100,
                        child: TabBarView(controller: controller, children: [
                          _.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : Obx(
                                  () => ShowProducts(
                                    refresh: _.fetchKFIInvestment,
                                    isLoading: _.isLoading.value,
                                    isError:
                                        _.isErrorFetchingMergeProduct.value,
                                    product: _.kfiProduct,
                                    errorMessage: _.errorMessage.value,
                                  ),
                                ),
                          _.isFetchingMerge.value
                              ? const Center(child: CircularProgressIndicator())
                              : _.users.isEmpty
                                  ? RefreshIndicator(
                                      onRefresh: _.fetchKFIAccount,
                                      child: SingleChildScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        child: SizedBox(
                                          height: Get.height * (.63),
                                          child: Center(
                                            child: NoDataScreen(
                                              oncall: () {},
                                              message: "No Kfi found",
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : RefreshIndicator(
                                      onRefresh: _.fetchKFIAccount,
                                      child: ListView.builder(
                                          itemCount: _.users.length,
                                          itemBuilder: (context, index) =>
                                              UserOverviewListTile(
                                                fullName:
                                                    _.users[index].fullName!,
                                                image:
                                                    _.users[index].profileImage,
                                                phone:
                                                    _.users[index].phoneNumber!,
                                                lga: _.users[index].lga!,
                                                state: _.users[index].state!,
                                                onTap: () => ViewInformation(
                                                    context, _.users[index], _),
                                              )),
                                    ),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  ViewInformation(context, MergeUsers user, HomeKFIController _) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user.profileImage != null &&
                          user.profileImage!.startsWith('http')
                      ? CachedNetworkImage(imageUrl: user.profileImage!)
                      : Image.asset(
                          Assets.assetsImagesImage,
                          scale: 3,
                        ),
                  // SizedBox(child: CW.button(onPress: () {}, text: "Unlink")),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("State").subTitle(),
                        Text(user.state!).title(
                          fontSize: 12,
                        ),
                        const Text("LGA").subTitle(),
                        Text(user.lga!).title(
                          fontSize: 12,
                        ),
                        const Text("Phone Number").subTitle(),
                        Text(user.phoneNumber!).title(
                          fontSize: 12,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Text('Full Name').subTitle(fontSize: 12),
              Text(user.fullName!).title(fontSize: 12),
              const Text("Email Address").subTitle(),
              Text(user.email!).title(
                fontSize: 12,
              ),
              const Text("Address").subTitle(),
              Text(user.address!).title(
                fontSize: 12,
              ),
              const Text("Own Vehicle").subTitle(),
              Text(user.ownVehicle! ? "Yes" : "No").title(
                fontSize: 12,
              ),
              CW.button(
                  onPress: () {
                    Get.back();
                    ConfirmUnlink(context, user.email!, _);
                  },
                  text: 'Unlink',
                  color: AppColor.red)
            ]),
      ),
    );
  }

  ConfirmUnlink(BuildContext context, String email, HomeKFIController _) {
    return showModalBottomSheet(
      enableDrag: true,
      context: context,
      clipBehavior: Clip.none,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => CW
                      .button(
                        isLoading: _.isUnlinking.value,
                        onPress: () => _.unlinkUser(email),
                        text: "Continue",
                      )
                      .halfWidth(width: .3),
                ),
                CW
                    .button(
                        onPress: Get.back, text: "Cancel", color: AppColor.red)
                    .halfWidth(width: .5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InviteUser(BuildContext context, HomeKFIController _,
      {bool isAccept = false}) {
    return showModalBottomSheet(
      enableDrag: true,
      context: context,
      clipBehavior: Clip.none,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CW.textField(
                  label: isAccept ? tCode : tEmailAddress,
                  inputType: isAccept
                      ? TextInputType.number
                      : TextInputType.emailAddress,
                  controller: isAccept ? _.code : _.email,
                  fieldName: isAccept ? tCode : tEmail,
                  validate: true,
                  onChangeValue: isAccept ? _.checkCode : _.changeEmailValue,
                ),
                Obx(
                  () => CW.button(
                      isLoading: _.isInviting.value,
                      onPress: _.hasValidInput.value
                          ? isAccept
                              ? _.acceptInvite
                              : _.inviteUser
                          : null,
                      text: isAccept ? 'Accept Invite' : "Invite"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
