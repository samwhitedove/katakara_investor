import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katakara_investor/customs/custom.widget.dart';
import 'package:katakara_investor/extensions/extensions.dart';
import 'package:katakara_investor/helper/helper.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.profile.dart';
import 'package:katakara_investor/values/values.dart';

// ignore: must_be_immutable
class FinancialScreen extends StatelessWidget {
  FinancialScreen({super.key});

  RxString selectedValue = finance.first.obs;
  RxString selected = userData.financialCapacity!.obs;

  @override
  Widget build(BuildContext context) {
    return CW.baseStackWidget(
      isLoading: isSaving.value,
      side: 15,
      children: [
        CW.AppSpacer(h: 60),
        CW.backButton(),
        CW.AppSpacer(h: 20),
        const Text("Financial Capacity").title(),
        CW.AppSpacer(h: 8),
        const Text("Select the capital amount to invest").subTitle(
          color: AppColor.text,
          fontSize: 16,
        ),
        CW.AppSpacer(h: 51),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CW.AppSpacer(h: 55),
            const Text("Current selected capacity")
                .subTitle(color: AppColor.text, fontSize: 14),
            CW.AppSpacer(h: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Text(selected.replaceAll("?", tNaira))
                      .title(color: AppColor.text, fontSize: 16),
                )
              ],
            ).roundCorner(
              bgColor: AppColor.primaryLight,
              width: HC.spaceVertical(356),
              borderColor: AppColor.primary,
            ),
            CW.AppSpacer(h: 40),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Obx(
                () => CW.dropdownString(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColor.grey,
                    ),
                  ),
                  label: tFinaceCapacity,
                  value: selectedValue.value,
                  onChange: (text) {
                    selectedValue.value = text;
                  },
                  data: finance,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CW.button(onPress: save, text: "Save"),
            ),
          ],
        ).roundCorner(
          bgColor: AppColor.primaryLight,
          width: Get.width,
          height: HC.spaceVertical(450),
          borderColor: AppColor.primaryLight,
        ),
      ],
    );
  }

  RxBool isSaving = false.obs;

  save() async {
    final profileService = Get.find<ProfileService>();
    isSaving.value = true;
    RequestResponsModel response = await profileService.updateUserInformation(
        data: {"financialCapacity": selectedValue.value});
    isSaving.value = false;
    if (response.success) selected.value = selectedValue.value;
    HC.snack(response.message, success: response.success);
  }
}
