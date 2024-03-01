import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katakara_investor/customs/custom.upload.card.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/values/colors.dart';
import 'package:katakara_investor/view/admin/broadcast/admin.broadcast.controller.dart';

class BroadcastView extends StatelessWidget {
  const BroadcastView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BroadcastController(),
        initState: (state) {},
        builder: (_) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CW.AppBr(
                      left: 0,
                      top: 40,
                      title: const Text("Broadcast").title(fontSize: 20),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CW.AppSpacer(h: 20),
                            Obx(
                              () => CW.dropdownString(
                                isLoading: false,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColor.grey,
                                  ),
                                ),
                                label: "Broadcast Type",
                                value: _.selectedBroadCast.value,
                                onChange: _.setCategory,
                                data: _.broadcastType,
                              ),
                            ),
                            CW.AppSpacer(h: 15),
                            Visibility(
                              visible: _.selectedBroadCast.value == "Location",
                              child: Obx(
                                () => CW.dropdownString(
                                  isLoading: false,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                  label: "State",
                                  value: _.selectedState.value,
                                  onChange: _.setState,
                                  data: _.states,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: GestureDetector(
                                    onTap: _.processImage.isNotEmpty
                                        ? null
                                        : () => showModal(_, false),
                                    child: Icon(
                                      _.processImage.isNotEmpty
                                          ? Icons.do_not_disturb_sharp
                                          : Icons.add,
                                      size: 30,
                                      color: _.processImage.isNotEmpty
                                          ? AppColor.grey
                                          : null,
                                    ).simpleRoundCorner(
                                      height: 70,
                                      width: 70,
                                      radius: 10,
                                      bgColor: AppColor.black.withAlpha(50),
                                    ),
                                  ),
                                ),
                                CW.AppSpacer(w: 15),
                                ...List.generate(
                                  _.processImage.length,
                                  (index) => Wrap(
                                    direction: Axis.horizontal,
                                    children: [
                                      CustomUploadCard(
                                        imageUrl: _.processImage[index].path,
                                        isLoading:
                                            _.processImage[index].isLoading!,
                                        isUploaded:
                                            _.processImage[index].isUploaded!,
                                        onDelete: () => _.deleteUploadedImage(
                                            _.processImage[index].id, false),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Text("Added image"),
                            CW.AppSpacer(h: 30),
                            CW.textField(
                              label: "Title",
                              controller: _.title,
                              onChangeValue: _.confirmCanSend,
                            ),
                            CW.AppSpacer(h: 30),
                            CW.textField(
                              lines: 5,
                              label: "Message",
                              controller: _.message,
                              onChangeValue: _.confirmCanSend,
                            ),
                            CW.AppSpacer(h: 30),
                            Obx(() => CW.button(
                                isLoading: _.isBroadcasting.value,
                                onPress:
                                    _.canSend.value || _.isBroadcasting.value
                                        ? _.sendBroadcast
                                        : null,
                                text: "Send")),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  showModal(BroadcastController provider, bool isSeller) {
    return Get.bottomSheet(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: AppColor.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => provider.handleImage(ImageSource.camera),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera,
                        size: 40,
                        color: AppColor.primary,
                      ),
                      const Text("Camera").subTitle(color: AppColor.primary)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => provider.handleImage(ImageSource.gallery),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.image,
                        size: 40,
                        color: AppColor.primary,
                      ),
                      const Text("Gallery").subTitle(color: AppColor.primary)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
